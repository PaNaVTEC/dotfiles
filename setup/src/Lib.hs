{-# LANGUAGE OverloadedStrings #-}

module Lib (entryPoint) where

import           Turtle
import           Commands
import           Network.Wreq
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy as BL
import           Data.Maybe (catMaybes)
import           Control.Lens

entryPoint :: IO ()
entryPoint = do
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

installPrinter :: IO ()
installPrinter = do
  _ <- aurInstall' ["cups", "nss-mdns", "gtk3-print-backends"]
  startService "orgs.cups.cupsd.service"
  startService "avahi-daemon.service"
  putStrLn "Add your printer in: http://localhost:631/"
  u' <- currentUser
  _ <- addUserToGroup u' ("sys" :: Text)
  return ()

installBt :: IO ()
installBt = do
  _ <- aurInstall' ["bluez", "bluez-utils", "bluez-qt", "pulseaudio-bluetooth"]
  _ <- run' "modprobe btusb"
  startService "bluetooth.service"
  return ()

installDevTools :: IO ()
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

installIntellij :: IO ()
installIntellij = do
  B.writeFile "/tmp/sysctl.d/99-sysctl.conf" "fs.inotify.max_user_watches = 524288"
  _ <- sudomv "/tmp/sysctl.d/99-sysctl.conf""/etc/sysctl.d/99-sysctl.conf"
  _ <- run' "sudo sysctl --system"
  return ()

installDocker :: IO ()
installDocker = do
  _ <- sudormdir "/var/lib/docker"
  dockerlib <- (~/) ".dockerlib"
  mktree dockerlib
  _ <- sudolnsfn dockerlib "/var/lib/docker"
  return ()

installRust :: IO ()
installRust = do
  _ <- aurInstall "rustup"
  _ <- run' "rustup toolchain install stable"
  _ <- run' "rustup default stable"
  _ <- run' "rustup toolchain install nightly"
  return ()

installJs :: IO ()
installJs = do
  _ <- aurInstall' ["nodejs", "npm", "yarn"]
  _ <- run' "yarn config set -- --emoji true"
  _ <- yarnInstallG "n"
  _ <- run' "n latest"
  _ <- yarnInstallG' ["tern", "standard", "create-react-app", "js-beautify", "typescript", "tslint", "eslint-plugin-typescript", "typescript-eslint-parser"]
  return ()

installHaskell :: IO ()
installHaskell = do
  _ <- aurInstall "stack-bin"
  _ <- run' "stack setup"
  _ <- stackInstall ["ghcid", "hindent", "stylish-haskell", "cabal-install", "hoogle", "hlint"]
  return ()

installGo :: IO ()
installGo = do
  _    <- aurInstall "go"
  bin  <- (~/) "go/bin"
  src  <- (~/) "go/src"
  mktrees [bin, src]
  cmdE <- commandExists "golint"
  unless cmdE $ void $ run' "go get -u github.com/golang/lint/golint"

installGit :: IO ()
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

installCompton :: IO ()
installCompton = do
  _ <- aurInstall' ["compton", "xorg-xwininfo"]
  beforeStartX <- (~/) ".before_startx"
  mktree beforeStartX
  let runsh = beforeStartX </> "run.sh"
  touch runsh
  B.writeFile (encodeString runsh) "compton -c -i 0.9 -b &"
  _ <- chmodx runsh
  return ()

configurePacman :: IO ()
configurePacman = do
  _ <- sudorm "/etc/pacman.conf"
  _ <- (`sudolnsfn` "/etc/pacman.conf") =<< pwd' "config/pacman/pacman.conf"
  updateMirrorList
  _ <- pacmanSync
  _ <- run' "sudo pacman-key --init"
  _ <- run' "sudo pacman-key --populate archlinux"
  _ <- pacmanUpdate
  return ()

installPacmanWrapper :: IO ()
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

updateMirrorList :: IO ()
updateMirrorList = do
  r <- get "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https"
  B.writeFile "/tmp/mirrorlist" (uncommentLines $ r ^. responseBody)
  _ <- sudorm "/etc/pacman.d/mirrorlist"
  _ <- sudomv "/tmp/mirrorlist" "/etc/pacman.d/mirrorlist"
  return ()
  where
    uncommentLines :: BL.ByteString -> B.ByteString
    uncommentLines lines' = B.unlines . catMaybes
      $ B.stripPrefix "#" <$> B.lines (BL.toStrict lines')
