{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Commands where

import           Turtle
import           Data.Text           (pack, strip, unpack)
import           Data.List
import qualified Data.ByteString.Char8 as B

run :: String -> Shell Line
run command = inshell (pack command) empty

run' :: MonadIO io => String -> io ExitCode
run' command = shell (pack command) empty

runpenv :: MonadIO io => [String] -> io ExitCode
runpenv = run' . join . intersperse " && "

lnsfn :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExitCode
lnsfn s' t = run' $ "ln -sfn " ++ encodeString s' ++ " " ++ encodeString t

sudolnsfn :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExitCode
sudolnsfn s' t = run' $ "sudo ln -sfn " ++ encodeString s' ++ " " ++ encodeString t

pacmanSync :: MonadIO io => io ExitCode
pacmanSync = run' "sudo pacman -Syy"

pacmanUpdate :: MonadIO io => io ExitCode
pacmanUpdate = run' "sudo pacman -Syu --noconfirm"

class ToPkgName a where toPkgName :: a -> PkgName
instance ToPkgName String where toPkgName = PkgName

newtype PkgName = PkgName { unPkgName :: String } deriving (Eq, Show, IsString)

pacmanInstall :: MonadIO io => PkgName -> io ExitCode
pacmanInstall pkg = run' $ "sudo pacman -S --noconfirm --needed " ++ unPkgName pkg

pacmanInstall' :: MonadIO io => [PkgName] -> io ExitCode
pacmanInstall' pkgs = run' $ "sudo pacman -S --noconfirm --needed " ++ (join . intersperse " " $ unPkgName <$> pkgs)

aurInstall :: MonadIO io => PkgName -> io ExitCode
aurInstall pkg = run' $ "yay --noconfirm -S --needed " ++ unPkgName pkg

aurInstall' :: MonadIO io => [PkgName] -> io ExitCode
aurInstall' pkgs = run' $ "yay --noconfirm -S --needed " ++ (join . intersperse " " $ unPkgName <$> pkgs)

aurInstallF :: MonadIO io => Prelude.FilePath -> io ExitCode
aurInstallF fp' = do
  pkgs <- liftIO $ B.lines <$> B.readFile fp'
  head $ aurInstall . PkgName . B.unpack <$> pkgs

(~/) :: MonadIO io => String -> io Turtle.FilePath
(~/) path = (\h -> h </> filePath path ) <$> home

pwd' :: MonadIO io => String -> io Turtle.FilePath
pwd' path = (\h -> h </> filePath path ) <$> pwd

filePath :: String -> Turtle.FilePath
filePath p = fromText $ pack p

mktrees :: [Turtle.FilePath] -> IO ()
mktrees = mapM_ mktree

chmodx :: MonadIO io => Turtle.FilePath -> io Permissions
chmodx = chmod (const $ Permissions True True True)

(&>) :: MonadIO io => Shell Line -> Turtle.FilePath -> io ()
line &> filepath = do
  touch filepath
  output filepath line

yarnInstallG :: MonadIO io => PkgName -> io ExitCode
yarnInstallG pkg = run' $ "yarn global add " ++ unPkgName pkg

yarnInstallG' :: MonadIO io => [PkgName] -> io ExitCode
yarnInstallG' pkgs = run' $ "yarn global add " ++ (join . intersperse " " $ unPkgName <$> pkgs)

sudorm :: MonadIO io => Turtle.FilePath -> io ExitCode
sudorm s' = run' $ "sudo rm " ++ encodeString s'

sudomv :: MonadIO io => Turtle.FilePath -> Turtle.FilePath -> io ExitCode
sudomv s' t = run' $ "sudo mv " ++ encodeString s' ++ " " ++ encodeString t

startService :: MonadIO io => String -> io ()
startService serv = do
  isEnabled <- exitsOk $ "systemctl is-enabled " <> serv
  unless isEnabled $
    do
    _ <- run' $ "sudo systemctl enable " <> serv
    _ <- run' $ "sudo systemctl start " <> serv
    return ()

addUserToGroup :: (MonadIO io, Show u, Show g) => u -> g -> io ExitCode
addUserToGroup user group' =
  run' $ "sudo usermod -a -G " <> show group' <> " " <> show user

commandExists :: MonadIO io => String -> io Bool
commandExists cmd' = exitsOk $ "which " <> cmd'

exitsOk :: MonadIO io => String -> io Bool
exitsOk cmd' = (== ExitSuccess) <$> run' cmd'

currentUser :: MonadIO io => io Text
currentUser = parseUser <$> strict (inshell (pack "id -u -n") empty)
  where parseUser = read . unpack . strip
