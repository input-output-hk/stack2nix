{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Stack2nix
  ( Args(..)
  , stack2nix
  , version
  ) where

import           Control.Monad              (unless, void)
import           Data.Char                  (toLower)
import           Data.Fix                   (Fix (..))
import           Data.List                  (foldl', isInfixOf, isSuffixOf,
                                             sort, union, (\\))
import qualified Data.Map.Strict            as Map
import           Data.Maybe                 (isJust)
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, unpack)
import           Distribution.Text          (display)
import           Nix.Atoms                  (NAtom (..))
import           Nix.Expr                   (Binding (..), NExpr, NExprF (..),
                                             NKeyName (..), ParamSet (..),
                                             Params (..))
import           Nix.Parser                 (Result (..), parseNixFile,
                                             parseNixString)
import           Nix.Pretty                 (prettyNix)
import           Path                       (parseAbsFile)
import           Paths_stack2nix            (version)
import           Stack.Config
import           Stack.Prelude              (LogLevel (..), runRIO)
import           Stack.Types.BuildPlan
import           Stack.Types.Config
import           Stack.Types.Runner
import           Stack2nix.External.Stack
import           Stack2nix.External.Util    (runCmdFrom)
import           Stack2nix.External.VCS.Git (Command (..), ExternalCmd (..),
                                             InternalCmd (..), git)
import           Stack2nix.Types            (Args (..))
import           Stack2nix.Util
import           System.Directory           (canonicalizePath, doesFileExist,
                                             getCurrentDirectory, withCurrentDirectory)
import           System.Environment         (getEnv)
import           System.FilePath            (dropExtension, isAbsolute,
                                             normalise, takeDirectory,
                                             takeFileName, (<.>), (</>))
import           System.FilePath.Glob       (glob)
import           System.IO.Temp             (withSystemTempDirectory)

stack2nix :: Args -> IO ()
stack2nix args@Args{..} = do
  checkRuntimeDeps
  updateCabalPackageIndex
  -- cwd <- getCurrentDirectory
  -- let projRoot = if isAbsolute argUri then argUri else cwd </> argUri
  let projRoot = argUri
  isLocalRepo <- doesFileExist $ projRoot </> "stack.yaml"
  logDebug args $ "stack2nix (isLocalRepo): " ++ show isLocalRepo
  logDebug args $ "stack2nix (projRoot): " ++ show projRoot
  logDebug args $ "stack2nix (argUri): " ++ show argUri
  if isLocalRepo
  then handleStackConfig Nothing projRoot
  else withSystemTempDirectory "s2n-" $ \tmpDir ->
    tryGit tmpDir >> handleStackConfig (Just argUri) tmpDir
  where
    checkRuntimeDeps :: IO ()
    checkRuntimeDeps = do
      assertMinVer "git" "2"
      assertMinVer "cabal" "2"

    updateCabalPackageIndex :: IO ()
    updateCabalPackageIndex =
      getEnv "HOME" >>= \home -> void $ runCmdFrom home "cabal" ["update"]

    tryGit :: FilePath -> IO ()
    tryGit tmpDir = do
      void $ git $ OutsideRepo $ Clone argUri tmpDir
      case argRev of
        Just r  -> void $ git $ InsideRepo tmpDir (Checkout r)
        Nothing -> return mempty

    handleStackConfig :: Maybe String -> FilePath -> IO ()
    handleStackConfig remoteUri localDir = do
      cwd <- getCurrentDirectory
      logDebug args $ "handleStackConfig (cwd): " ++ cwd
      logDebug args $ "handleStackConfig (localDir): " ++ localDir
      logDebug args $ "handleStackConfig (remoteUri): " ++ show remoteUri
      let stackFile = localDir </> "stack.yaml"
      alreadyExists <- doesFileExist stackFile
      unless alreadyExists $ void $ runCmdFrom localDir "stack" ["init", "--system-ghc"]
      logDebug args $ "handleStackConfig (alreadyExists): " ++ show alreadyExists
      cp <- canonicalizePath stackFile
      fp <- parseAbsFile cp
      lc <- withRunner LevelError True False ColorAuto Nothing False $ \runner ->
        -- https://www.fpcomplete.com/blog/2017/07/the-rio-monad
        runRIO runner $ loadConfig mempty Nothing (SYLOverride fp)
      if isJust remoteUri then withCurrentDirectory localDir (toNix args remoteUri localDir lc) else toNix args remoteUri localDir lc


toNix :: Args -> Maybe String -> FilePath -> LoadConfig -> IO ()
toNix args@Args{..} remoteUri baseDir lc = do
  bc <- lcLoadBuildConfig lc Nothing -- compiler
  withSystemTempDirectory "s2n" $ \outDir -> do
    let packages = filter (\p -> case p of
                                   PLIndex _          -> False
                                   PLOther (PLRepo _) -> True
                                   _ -> error $ "Unsupported build config dependency: " ++ show p) (bcDependencies bc)
    runPlan baseDir outDir remoteUri (map toPackageRef packages) lc args $ patchAndMerge args baseDir bc outDir
  where
    toPackageRef :: PackageLocationIndex Subdirs -> PackageRef
    toPackageRef (PLOther (PLRepo repo)) = RepoPackage repo
    toPackageRef p = error $ "Unsupported package location index: " ++ show p

patchAndMerge :: Args -> FilePath -> BuildConfig -> FilePath -> IO ()
patchAndMerge Args{..} baseDir BuildConfig{..} outDir = do
  nixFiles <- glob (outDir </> "*.nix")
  overrides <- mapPool argThreads overrideFor nixFiles
  void $ mapPool argThreads patchNixFile nixFiles
  writeFile (outDir </> "initialPackages.nix") $ initialPackages $ sort overrides
  pullInNixFiles $ outDir </> "initialPackages.nix"
  nf <- parseNixFile $ outDir </> "initialPackages.nix"
  case nf of
    Success expr ->
      case argOutFile of
        Just fname -> writeFile fname $ defaultNix expr
        Nothing    -> putStrLn $ defaultNix expr
    _ -> error "failed to parse intermediary initialPackages.nix file"
  where

    -- Given a path to a package with Cabal file inside, return Cabal package name
    localPackageName :: FilePath -> IO String
    localPackageName dir = do
      [cabal] <- glob (dir </> "*.cabal")
      contents <- readFile cabal
      let nameLine = head [x | x <- lines contents, "name" `isInfixOf` map toLower x]
      pure . reverse . takeWhile (/= ' ') . reverse $ nameLine

    -- Returns a list of names of local packages
    localPackages :: IO [String]
    localPackages =
      mapM (\p -> case p of
                    PLFilePath subDir -> localPackageName (baseDir </> subDir)
                    PLArchive _ -> error "Arhive local dependencies not supported"
                    PLRepo _ -> error "Repo local dependencies not supported") bcPackages

    patchNixFile :: FilePath -> IO ()
    patchNixFile fname = do
      contents <- readFile fname
      case parseNixString contents of
        Success expr ->
          case takeFileName fname of
            "hspec.nix" ->
              writeFile fname $ show $ prettyNix $ (addParam "stringbuilder" . stripNonEssentialDeps False) expr
            _ -> do
              pkgs <- localPackages
              let
                shouldPatch = any (\p -> (p <.> "nix") `isSuffixOf` fname) pkgs
                shouldTest = argTest && shouldPatch
                expr' = stripNonEssentialDeps shouldTest (if shouldTest then enableAttr "doCheck" expr else expr)
                expr'' = if argHaddock && shouldPatch then enableAttr "doHaddock" expr' else expr'
              writeFile fname $ show $ prettyNix expr''
        _ -> error "failed to parse intermediary nix package file"

    enableAttr :: Text -> NExpr -> NExpr
    enableAttr key expr =
      case expr of
        Fix (NAbs paramSet (Fix (NApp mkDeriv (Fix (NSet attrs))))) ->
          let attrs' = map patchAttr attrs in
          Fix (NAbs paramSet (Fix (NApp mkDeriv (Fix (NSet attrs')))))
        _ ->
          error $ "unhandled nix expression format\n" ++ show expr
      where
        patchAttr :: Binding (Fix NExprF) -> Binding (Fix NExprF)
        patchAttr attr = case attr of
                           NamedVar [StaticKey k] (Fix (NConstant (NBool False))) ->
                             if k == key
                             then NamedVar [StaticKey k] (Fix (NConstant (NBool True)))
                             else attr
                           x -> x

    addParam :: String -> NExpr -> NExpr
    addParam param expr =
      let contents = show $ prettyNix expr
          (l:ls) = lines contents
          (openBrace, params) = splitAt 1 (words l)
          l' = unwords $ openBrace ++ [param ++ ", "] ++ params
      in
      case parseNixString $ unlines (l':ls) of
        Success expr' -> expr'
        _             -> expr

    stripNonEssentialDeps :: Bool -> NExpr -> NExpr
    stripNonEssentialDeps keepTests expr =
      let benchSects = ["benchmarkHaskellDepends", "benchmarkToolDepends"]
          testSects = ["testHaskellDepends", "testToolDepends"]
          otherSects = [ "executableHaskellDepends"
                       , "executableToolDepends"
                       , "libraryHaskellDepends"
                       , "librarySystemDepends"
                       , "libraryToolDepends"
                       , "setupHaskellDepends"
                       ]
          sectsToDrop = if keepTests then benchSects else benchSects `union` testSects
          sectsToKeep = if keepTests then otherSects `union` testSects else otherSects
          collectDeps sects = foldr union [] $ fmap (dependenciesFromSection expr) sects
          depsToStrip = collectDeps sectsToDrop \\ collectDeps sectsToKeep
          expr' = foldl dropDependencySection expr sectsToDrop
      in
      dropParams expr' depsToStrip

    overrideFor :: FilePath -> IO String
    overrideFor nixFile = do
      deps <- externalDeps
      return $ "    " <> (dropExtension . takeFileName) nixFile <> " = callPackage ./" <> takeFileName nixFile <> " { " <> deps <> " };"
      where
        externalDeps :: IO String
        externalDeps = do
          deps <- librarySystemDeps nixFile
          return . unwords $ fmap (\d -> unpack d <> " = pkgs." <> unpack d <> ";") deps

    pullInNixFiles :: FilePath -> IO ()
    pullInNixFiles nixFile = do
      nf <- parseNixFile nixFile
      case nf of
        Success expr ->
          case expr of
            Fix (NAbs paramSet (Fix (NAbs fnParam (Fix (NSet attrs))))) -> do
              attrs' <- mapM patchAttr attrs
              let expr' = Fix (NAbs paramSet (Fix (NAbs fnParam (Fix (NSet attrs')))))
              writeFile nixFile $ (++ "\n") $ show $ prettyNix expr'
            _ ->
              error $ "unhandled nix expression format\n" ++ show expr
        _ -> error "failed to parse nix file!"
        where
          patchAttr :: Binding (Fix NExprF) -> IO (Binding (Fix NExprF))
          patchAttr attr =
            case attr of
              NamedVar k (Fix (NApp (Fix (NApp (Fix (NSym "callPackage")) pkg)) deps)) -> do
                pkg' <- patchPkgRef pkg
                return $ NamedVar k (Fix (NApp (Fix (NApp (Fix (NSym "callPackage")) pkg')) deps))
              _ -> error "unhandled NamedVar"

          patchPkgRef (Fix (NLiteralPath path)) = do
            let p = if isAbsolute path then path else normalise $ takeDirectory nixFile </> path
            nf <- parseNixFile p
            case nf of
              Success expr -> return expr
              _ -> error $ "failed to parse referenced nix file '" ++ path ++ "'"
          patchPkgRef x                   = return x

    dependenciesFromSection :: NExpr -> String -> [Text]
    dependenciesFromSection expr name =
      case expr of
        Fix (NAbs _ (Fix (NApp _ (Fix (NSet namedVars))))) ->
          case lookupNamedVar namedVars name of
            Just (Fix (NList deps)) ->
              foldl' (\acc x ->
                        case x of
                          Fix (NSym n) -> n : acc
                          _            -> acc) [] deps
            _ -> []
        _ -> []

    librarySystemDeps :: FilePath -> IO [Text]
    librarySystemDeps nixFile = do
      nf <- parseNixFile nixFile
      case nf of
        Success expr -> return $ dependenciesFromSection expr "librarySystemDepends"
        _            -> return []

    dropDependencySection :: NExpr -> String -> NExpr
    dropDependencySection expr name =
      case expr of
        Fix (NAbs a (Fix (NApp b (Fix (NSet namedVars))))) ->
          Fix (NAbs a (Fix (NApp b (Fix (NSet $ dropNamedVar namedVars name)))))
        _ -> expr

    lookupNamedVar :: [Binding a] -> String -> Maybe a
    lookupNamedVar [] _ = Nothing
    lookupNamedVar (x:xs) name =
      case x of
        NamedVar [StaticKey k] val ->
          if unpack k == name
          then Just val
          else lookupNamedVar xs name
        _ -> lookupNamedVar xs name

    dropNamedVar :: [Binding a] -> String -> [Binding a]
    dropNamedVar xs name = filter differentName xs
      where
        differentName (NamedVar [StaticKey k] _) = unpack k /= name
        differentName _                          = True

    dropParams :: NExpr -> [Text] -> NExpr
    dropParams (Fix (NAbs (ParamSet (FixedParamSet paramMap) x)
                (Fix (NApp mkDeriv (Fix (NSet args)))))) names =
      Fix (NAbs (ParamSet (FixedParamSet $ foldr Map.delete paramMap names) x)
                (Fix (NApp mkDeriv (Fix (NSet args)))))
    dropParams x _ = x

    initialPackages overrides = unlines $
      [ "{ pkgs, stdenv, callPackage }:"
      , ""
      , "self: {"
      ] ++ overrides ++
      [ "}"
      ]

    defaultNix pkgsNixExpr = unlines
      [ "# Generated using stack2nix " ++ display version ++ "."
      , "#"
      , "# Only works with sufficiently recent nixpkgs, e.g. \"NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/21a8239452adae3a4717772f4e490575586b2755.tar.gz\"."
      , ""
      , "{ pkgs ? (import <nixpkgs> {})"
      , ", compiler ? pkgs.haskell.packages.ghc802"
      , ", ghc ? pkgs.haskell.compiler.ghc802"
      , "}:"
      , ""
      , "with pkgs.haskell.lib;"
      , ""
      , "let"
      , "  stackPackages = " ++ show (prettyNix pkgsNixExpr) ++ ";"
      , "in"
      , "compiler.override {"
      , "  initialPackages = stackPackages;"
      , "  configurationCommon = { ... }: self: super: {};"
      , "}"
      ]
