{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}

module Lib (entryPoint) where

import           Commands
import           Control.Lens
import           Control.Monad.Except
import           Control.Monad.Trans
import qualified Data.ByteString.Char8      as B
import qualified Data.ByteString.Lazy       as BL
import           Data.Maybe                        (catMaybes)
import           Network.Wreq
import           Turtle

type App m = AppT m ()
newtype AppT m a = App
  { unApp :: ExceptT Text m a
  } deriving
  (Functor, Applicative, Monad, MonadIO, MonadError Text)

entryPoint :: IO ()
entryPoint = void . runExceptT . unApp $ install'

install' :: MonadIO io => App io
install' = do
  configurePacman
  installPacmanWrapper
  _ <- aurInstallF "./yaourt_i3.txt"
  installCompton
  installDevTools
  installBt
  installPrinter
  _ <- aurInstallF "./yaourt_fonts.txt"
  _ <- aurInstallF "./yaourt_tools.txt"
  _ <- aurInstallF "./yaourt_urxvt.txt"
  _ <- aurInstallF "./yaourt_themes.txt"
  _ <- aurInstallF "./yaourt_audio.txt"
  return ()

installPrinter :: MonadIO io => App io
installPrinter = do
  _ <- aurInstall' ["cups", "nss-mdns", "gtk3-print-backends"]
  startService "orgs.cups.cupsd.service"
  startService "avahi-daemon.service"
  liftIO $ putStrLn "Add your printer in: http://localhost:631/"
  _ <- addCurrentUserToGroup "sys"
  return ()

installBt :: MonadIO io => App io
installBt = do
  _ <- aurInstall' ["bluez", "bluez-utils", "bluez-qt", "pulseaudio-bluetooth"]
  _ <- run' "modprobe btusb"
  startService "bluetooth.service"
  return ()

installDevTools :: MonadIO io => App io
installDevTools = do
  installGit
  _ <- aurInstallF "./yaourt_java.txt"
  _ <- aurInstallF "./yaourt_android.txt"
  _ <- aurInstallF "./yaourt_scala.txt"
  _ <- aurInstallF "./yaourt_devtools.txt"
  _ <- aurInstallF "./yaourt_clojure.txt"
  _ <- aurInstall' ["shellcheck-static", "shunit2"]
  _ <- aurInstall' ["emacs", "aspell", "aspell-en", "aspell-es"]
  installJs
  installHaskell
  installGo
  installRust
  installDocker
  installIntellij

installIntellij :: MonadIO io => App io
installIntellij = do
  liftIO $ B.writeFile "/tmp/sysctl.d/99-sysctl.conf" "fs.inotify.max_user_watches = 524288"
  _ <- sudomv "/tmp/sysctl.d/99-sysctl.conf""/etc/sysctl.d/99-sysctl.conf"
  _ <- run' "sudo sysctl --system"
  return ()

installDocker :: MonadIO io => App io
installDocker = do
  _ <- sudormdir "/var/lib/docker"
  dockerlib <- (~/) ".dockerlib"
  mktree dockerlib
  _ <- sudolnsfn dockerlib "/var/lib/docker"
  return ()

installRust :: MonadIO io => App io
installRust = do
  _ <- aurInstall "rustup"
  _ <- run' "rustup toolchain install stable"
  _ <- run' "rustup default stable"
  _ <- run' "rustup toolchain install nightly"
  return ()

installJs :: MonadIO io => App io
installJs = do
  _ <- aurInstall' ["nodejs", "npm", "yarn"]
  _ <- run' "yarn config set -- --emoji true"
  _ <- yarnInstallG "n"
  _ <- run' "n latest"
  _ <- yarnInstallG' ["tern", "standard", "create-react-app", "js-beautify", "typescript", "tslint", "eslint-plugin-typescript", "typescript-eslint-parser"]
  return ()

installHaskell :: MonadIO io => App io
installHaskell = do
  _ <- aurInstall "stack-bin"
  _ <- run' "stack setup"
  _ <- stackInstall ["ghcid", "hindent", "stylish-haskell", "cabal-install", "hoogle", "hlint"]
  return ()

installGo :: MonadIO io => App io
installGo = do
  _    <- aurInstall "go"
  bin  <- (~/) "go/bin"
  src  <- (~/) "go/src"
  liftIO $ mktrees [bin, src]
  cmdE <- commandExists "golint"
  unless cmdE $ void $ run' "go get -u github.com/golang/lint/golint"

installGit :: MonadIO io => App io
installGit = sh $ do
  _ <- aurInstallF "./yaourt_git.txt"
  createGitIgnore
  where
    createGitIgnore = do
      _    <- run "gibo update"
      let content = run "gibo dump Emacs Vim JetBrains Ensime Tags Vagrant Windows macOS Linux Archives"
      path <- (~/) ".gitignore.global"
      content &> path
      append path ".tern-project"
      append path ".tern-port"

installCompton :: MonadIO io => App io
installCompton = do
  _ <- aurInstall' ["compton", "xorg-xwininfo"]
  beforeStartX <- (~/) ".before_startx"
  mktree beforeStartX
  let runsh = beforeStartX </> "run.sh"
  touch runsh
  liftIO $ B.writeFile (encodeString runsh) "compton -c -i 0.9 -b &"
  _ <- chmodx runsh
  return ()

configurePacman :: MonadIO io => App io
configurePacman = do
  _ <- sudorm "/etc/pacman.conf"
  _ <- (`sudolnsfn` "/etc/pacman.conf") =<< pwd' "config/pacman/pacman.conf"
  updateMirrorList
  _ <- pacmanSync
  _ <- run' "sudo pacman-key --init"
  _ <- run' "sudo pacman-key --populate archlinux"
  _ <- pacmanUpdate
  return ()

installPacmanWrapper :: MonadIO io => App io
installPacmanWrapper = do
  _ <- pacmanInstall' ["base-devel", "git", "wget", "yajl", "go"]
  _ <- installYay
  _ <- aurInstall "reflector"
  return ()
  where
    installYay = do
      cmdE <- commandExists "yay"
      unless cmdE . void . runpenv $
        ["git clone https://aur.archlinux.org/yay.git /tmp/yay/"
        ,"cd /tmp/yay"
        ,"makepkg -si --noconfirm"
        ]

updateMirrorList :: MonadIO io => App io
updateMirrorList = do
  r <- liftIO $ get "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https"
  liftIO $ B.writeFile "/tmp/mirrorlist" (uncommentLines $ r ^. responseBody)
  _ <- sudorm "/etc/pacman.d/mirrorlist"
  _ <- sudomv "/tmp/mirrorlist" "/etc/pacman.d/mirrorlist"
  return ()
  where
    uncommentLines :: BL.ByteString -> B.ByteString
    uncommentLines lines' = B.unlines . catMaybes
      $ B.stripPrefix "#" <$> B.lines (BL.toStrict lines')
