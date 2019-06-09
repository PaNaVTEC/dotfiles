{-# LANGUAGE ExtendedDefaultRules       #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}

module Commands where

import           Data.Bool             (bool)
import qualified Data.ByteString.Char8 as B
import           Data.List
import           Data.Text             (pack)
import           Turtle

type ExecResult = Either Text Text

run :: String -> Shell Line
run command = inshell (pack command) empty

prun :: MonadIO io => Text -> io ExecResult
prun command = toOutput <$> shellStrictWithErr command empty
  where
    toOutput (ExitSuccess, out, _) = Right out
    toOutput (_, _, e')            = Left e'

prun' :: MonadIO io => Text -> io ()
prun' = void . prun

runpenv :: MonadIO io => [String] -> io ExecResult
runpenv = prun . pack . join . Data.List.intersperse " && "

lnsfn :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExecResult
lnsfn s' t = prun . pack $ "ln -sfn " <> encodeString s' <> " " <> encodeString t

sudolnsfn :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExecResult
sudolnsfn s' t = prun .pack $ "sudo ln -sfn " <> encodeString s' <> " " <> encodeString t

pacmanSync :: MonadIO io => io ExecResult
pacmanSync = prun "sudo pacman -Syy"

pacmanUpdate :: MonadIO io => io ExecResult
pacmanUpdate = prun "sudo pacman -Syu --noconfirm"

class ToPkgName a where toPkgName :: a -> PkgName
instance ToPkgName String where toPkgName = PkgName

newtype PkgName = PkgName { unPkgName :: String } deriving (Eq, Show, IsString)

pacmanInstall :: MonadIO io => PkgName -> io ExecResult
pacmanInstall pkg = prun . pack $ "sudo pacman -S --noconfirm --needed " <> unPkgName pkg

pacmanInstall' :: MonadIO io => [PkgName] -> io ExecResult
pacmanInstall' pkgs = prun . pack
  $ "sudo pacman -S --noconfirm --needed " <> (join . Data.List.intersperse " " $ unPkgName <$> pkgs)

aurInstall :: MonadIO io => PkgName -> io ExecResult
aurInstall pkg = prun . pack $ "yay --noconfirm -S --needed " <> unPkgName pkg

aurInstall' :: MonadIO io => [PkgName] -> io ExecResult
aurInstall' pkgs = prun . pack $ "yay --noconfirm -S --needed " <> (join . Data.List.intersperse " " $ unPkgName <$> pkgs)

aurInstallF :: MonadIO io => Prelude.FilePath -> io ExecResult
aurInstallF fp' = do
  pkgs <- liftIO $ B.lines <$> B.readFile fp'
  head $ aurInstall . PkgName . B.unpack <$> pkgs

aurInstallF' :: MonadIO io => Prelude.FilePath -> io ()
aurInstallF' = void . aurInstallF

(~/) :: MonadIO io => String -> io Turtle.FilePath
(~/) path = (\h -> h </> filePath path) <$> home

pwd' :: MonadIO io => String -> io Turtle.FilePath
pwd' path = (\h -> h </> filePath path) <$> pwd

filePath :: String -> Turtle.FilePath
filePath p = fromText $ pack p

mktrees :: [Turtle.FilePath] -> IO ()
mktrees = mapM_ mktree

chmodx :: MonadIO io => Turtle.FilePath -> io ExecResult
chmodx fp' =
  bool
    (Left "Permissions not changed correctly")
    (Right "")
  . (== execPermissions)
  <$> chmod (const execPermissions) fp'
  where
    execPermissions = Permissions True True True

(&>) :: MonadIO io => Shell Line -> Turtle.FilePath -> io ()
line &> filepath = do
  touch filepath
  output filepath line
infixr 5 &>

(&>>) :: MonadIO io => B.ByteString -> Turtle.FilePath -> io ExecResult
inp &>> filepath = liftIO $ do
  let tmpFilePath = "/tmp/i-am-a-tmp-file"
  touch (fromString tmpFilePath)
  B.writeFile tmpFilePath inp
  sudomv (fromString tmpFilePath) filepath
infixr 5 &>>

yarnInstallG :: MonadIO io => PkgName -> io ExecResult
yarnInstallG pkg = prun . pack $ "yarn global add " <> unPkgName pkg

yarnInstallG' :: MonadIO io => [PkgName] -> io ExecResult
yarnInstallG' pkgs = prun . pack $ "yarn global add " <> (join . Data.List.intersperse " " $ unPkgName <$> pkgs)

stackInstall :: MonadIO io => [PkgName] -> io ExecResult
stackInstall pkgs = prun . pack $ "stack install " <> (join . Data.List.intersperse " " $ unPkgName <$> pkgs)

sudorm :: MonadIO io => Turtle.FilePath -> io ExecResult
sudorm s' = prun . pack $ "sudo rm " <> encodeString s'

sudormdir :: MonadIO io => Turtle.FilePath -> io ExecResult
sudormdir s' = prun . pack $ "sudo rm -rf " <> encodeString s'

sudomv :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExecResult
sudomv s' t = prun . pack $ "sudo mv " <> encodeString s' <> " " <> encodeString t

startService :: MonadIO io => Text -> io ExecResult
startService serv = do
  isEnabled <- exitsOk $ "systemctl is-enabled " <> serv
  if isEnabled
  then do
    execRes <- prun $ "sudo systemctl enable " <> serv
    _ <- prun $ "sudo systemctl start " <> serv
    pure execRes
  else pure $ Right ""

addCurrentUserToGroup :: MonadIO io => Text -> io ExecResult
addCurrentUserToGroup group' = do
  res' <- currentUser
  case res' of
    (Right u') -> addUserToGroup u' group'
    t          -> pure t

addUserToGroup :: MonadIO io => Text -> Text -> io ExecResult
addUserToGroup user group' =
  prun $ "sudo usermod -a -G " <> group' <> " " <> user

commandExists :: MonadIO io => Text -> io Bool
commandExists cmd' = not <$> exitsOk ("which " <> cmd')

exitsOk :: MonadIO io => Text -> io Bool
exitsOk cmd' = exitsOk' <$> prun cmd'
  where
    exitsOk' (Right _) = True
    exitsOk' _         = False

currentUser :: MonadIO io => io ExecResult
currentUser = prun "id -u -n"
