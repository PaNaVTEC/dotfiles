{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RankNTypes                 #-}

module Lib (entryPoint) where

import           Commands
import           Control.Lens          ((^.))
import           Control.Monad.Except
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy  as BL (ByteString, toStrict)
import           Data.Maybe            (catMaybes)
import           Data.Text             as Tx (unpack)
import           Network.Wreq          (get, responseBody)
import           Turtle

type App m = AppT m ()
newtype AppT m a = AppT
  { unApp :: ExceptT Text m a
  } deriving
  (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadTrans)

entryPoint :: IO ()
entryPoint = void . runExceptT . unApp . printErrorAndContinue $ install'

install' :: MonadIO io => App io
install' = do
  updateMirrorList
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

configurePacman :: MonadIO io => App io
configurePacman = printErrorAndContinue $ do
  (*!) $ sudorm "/etc/pacman.conf"
  (*!) $ (`sudolnsfn` "/etc/pacman.conf") =<< pwd' "config/pacman/pacman.conf"
  (*!) pacmanSync
  (*!) $ prun "sudo pacman-key --init"
  (*!) $ prun "sudo pacman-key --populate archlinux"
  (*!) pacmanUpdate

updateMirrorList :: (MonadIO io) => App io
updateMirrorList = printErrorAndContinue $ do
  r <- liftIO $ get "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https"
  liftIO $ B.writeFile "/tmp/mirrorlist" (uncommentLines $ r ^. responseBody)
  (*!) $ sudorm "/etc/pacman.d/mirrorlist"
  (*!) $ sudomv "/tmp/mirrorlist" "/etc/pacman.d/mirrorlist"
  where
    uncommentLines :: BL.ByteString -> B.ByteString
    uncommentLines lines' = B.unlines . catMaybes
      $ B.stripPrefix "#" <$> B.lines (BL.toStrict lines')

installPacmanWrapper :: MonadIO io => App io
installPacmanWrapper = do
  (*!) $ pacmanInstall' ["base-devel", "git", "wget", "yajl", "go"]
  (*!) installYay
  void $ aurInstall "reflector"
  where
    installYay = do
      cmdE <- commandExists "yay"
      if cmdE
      then runpenv
        ["git clone https://aur.archlinux.org/yay.git /tmp/yay/"
        ,"cd /tmp/yay"
        ,"makepkg -si --noconfirm"
        ]
      else pure $ Right ""

installPrinter :: MonadIO io => App io
installPrinter = printErrorAndContinue $ do
  (*!) $ aurInstall' ["cups", "nss-mdns", "gtk3-print-backends"]
  (*!) $ startService "orgs.cups.cupsd.service"
  (*!) $ startService "avahi-daemon.service"
  liftIO $ putStrLn "Add your printer in: http://localhost:631/"
  (*!) $ addCurrentUserToGroup "sys"

installBt :: MonadIO io => App io
installBt = printErrorAndContinue $ do
  (*!) $ aurInstall' ["bluez", "bluez-utils", "bluez-qt", "pulseaudio-bluetooth"]
  prun' "modprobe btusb"
  (*!) $ startService "bluetooth.service"

installDevTools :: MonadIO io => App io
installDevTools = printErrorAndContinue $ do
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
installIntellij = printErrorAndContinue $ do
  liftIO $ B.writeFile "/tmp/sysctl.d/99-sysctl.conf" "fs.inotify.max_user_watches = 524288"
  (*!) $ sudomv "/tmp/sysctl.d/99-sysctl.conf""/etc/sysctl.d/99-sysctl.conf"
  prun' "sudo sysctl --system"

installDocker :: MonadIO io => App io
installDocker = printErrorAndContinue $ do
  (*!) $ sudormdir "/var/lib/docker"
  dockerlib <- (~/) ".dockerlib"
  mktree dockerlib
  _ <- sudolnsfn dockerlib "/var/lib/docker"
  return ()

installRust :: MonadIO io => App io
installRust = printErrorAndContinue $ do
  (*!) $ aurInstall "rustup"
  prun' "rustup toolchain install stable"
  prun' "rustup default stable"
  prun' "rustup toolchain install nightly"

installJs :: MonadIO io => App io
installJs = printErrorAndContinue $ do
  (*!) $ aurInstall' ["nodejs", "npm", "yarn"]
  prun' "yarn config set -- --emoji true"
  _ <- yarnInstallG "n"
  prun' "n latest"
  _ <- yarnInstallG' ["tern", "standard", "create-react-app", "js-beautify", "typescript", "tslint", "eslint-plugin-typescript", "typescript-eslint-parser"]
  return ()

installHaskell :: MonadIO io => App io
installHaskell = printErrorAndContinue $ do
  (*!) $ aurInstall "stack-bin"
  (*!) $ prun "stack setup"
  (*!) $ stackInstall ["ghcid", "hindent", "stylish-haskell", "cabal-install", "hoogle", "hlint"]

installGo :: MonadIO io => App io
installGo = printErrorAndContinue $ do
  (*!) $ aurInstall "go"
  bin  <- (~/) "go/bin"
  src  <- (~/) "go/src"
  liftIO $ mktrees [bin, src]
  cmdE <- commandExists "golint"
  unless cmdE $ prun' "go get -u github.com/golang/lint/golint"

installGit :: MonadIO io => App io
installGit = printErrorAndContinue $ do
  (*!) $ aurInstallF "./yaourt_git.txt"
  createGitIgnore
  where
    createGitIgnore = sh $ do
      _    <- run "gibo update"
      let content = run "gibo dump Emacs Vim JetBrains Ensime Tags Vagrant Windows macOS Linux Archives"
      path <- (~/) ".gitignore.global"
      content &> path
      append path ".tern-project"
      append path ".tern-port"

installCompton :: MonadIO io => App io
installCompton = do
  (*!) $ aurInstall' ["compton", "xorg-xwininfo"]
  beforeStartX <- (~/) ".before_startx"
  mktree beforeStartX
  let runsh = beforeStartX </> "run.sh"
  touch runsh
  liftIO $ B.writeFile (encodeString runsh) "compton -c -i 0.9 -b &"
  _ <- chmodx runsh
  return ()

printErrorAndContinue :: MonadIO io => App io -> App io
printErrorAndContinue = ignoreExcept (putStrLn . Tx.unpack)

ignoreExcept :: MonadIO io => (Text -> IO ()) -> App io -> App io
ignoreExcept f' app' = lift $ do
  result <- runExceptT . unApp $ app'
  either
    (liftIO . f')
    pure
    result

breakIfFail :: MonadIO io => io ExecResult -> App io
breakIfFail res' = void $ liftEither =<< lift res'

(*!) :: MonadIO io => io ExecResult -> App io
(*!) = breakIfFail
