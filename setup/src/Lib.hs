{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RankNTypes                 #-}

module Lib  where

import           Commands
import           Control.Monad.Except
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy  as BL (ByteString, toStrict)
import           Data.Maybe            (catMaybes)
import           Data.Text             as Tx (Text, unpack)
import           Data.Text.Encoding    as Tx (encodeUtf8)
import           Network.Wreq          (get)
import           Turtle                (append, mktree, (</>))
import           Network.HTTP.Client   (responseBody)

-- TODO add MonadLogger with file support
type App m = AppT m ()
newtype AppT m a = AppT
  { unApp :: ExceptT Text m a
  } deriving
  (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadTrans)

entryPoint :: IO ()
entryPoint = void . runExceptT . unApp . printErrorAndContinue $ install'

install' :: MonadIO io => App io
install' = do
  "Mirror list"      *#> updateMirrorList
  "Configure pacman" *!> configurePacman
  "Upading system"   *!> pacmanUpdate
  "Pacman wrapper"   *!> installPacmanWrapper
  "i3"               *#> aurInstallF' "./yaourt_i3.txt"
  "Compton"          *#> installCompton
  "Dev tools"        *#> installDevTools
  "Bluetooth"        *#> installBt
  "Printer"          *#> installPrinter
  "Fonts"            *#> aurInstallF' "./yaourt_fonts.txt"
  "Tools"            *#> aurInstallF' "./yaourt_tools.txt"
  "Urvt"             *#> aurInstallF' "./yaourt_urxvt.txt"
  "Themes"           *#> aurInstallF' "./yaourt_themes.txt"
  "Audio"            *#> aurInstallF' "./yaourt_audio.txt"

configurePacman :: MonadIO io => App io
configurePacman = do
  (*!) $ sudorm "/etc/pacman.conf"
  (*!) $ (`sudolnsfn` "/etc/pacman.conf") =<< pwd' "config/pacman/pacman.conf"
  (*!) pacmanSync
  (*!) $ prun "sudo pacman-key --init"
  (*!) $ prun "sudo pacman-key --populate archlinux"

updateMirrorList :: (MonadIO io) => App io
updateMirrorList = do
  r <- liftIO $ get "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https"
  (*!) $ uncommentLines (responseBody r) &>> "/etc/pacman.d/mirrorlist"
  where
    uncommentLines :: BL.ByteString -> B.ByteString
    uncommentLines lines' = B.unlines . catMaybes
      $ B.stripPrefix "#" <$> B.lines (BL.toStrict lines')

installPacmanWrapper :: MonadIO io => App io
installPacmanWrapper = do
  (*!) $ pacmanInstall' ["base-devel", "git", "wget", "yajl", "go-pie"]
  (*!) installYay
  void $ aurInstall "reflector"
  where
    installYay = do
      cmdE <- commandExists "yay"
      if cmdE
      then pure $ Right ""
      else runpenv
        ["git clone https://aur.archlinux.org/yay.git /tmp/yay/"
        ,"cd /tmp/yay"
        ,"makepkg -si --noconfirm"
        ]

installPrinter :: MonadIO io => App io
installPrinter = do
  (*!) $ aurInstall' ["cups", "nss-mdns", "gtk3-print-backends"]
  (*!) $ startService "orgs.cups.cupsd.service"
  (*!) $ startService "avahi-daemon.service"
  (*!) $ addCurrentUserToGroup "sys"

installBt :: MonadIO io => App io
installBt = do
  (*!) $ aurInstall' ["bluez", "bluez-utils", "bluez-qt", "pulseaudio-bluetooth"]
  prun' "modprobe btusb"
  (*!) $ startService "bluetooth.service"

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
  (*!) $ "fs.inotify.max_user_watches = 524288" &>> "/etc/sysctl.d/99-sysctl.conf"
  prun' "sudo sysctl --system"

installDocker :: MonadIO io => App io
installDocker = do
  (*!) $ sudormdir "/var/lib/docker"
  dockerlib <- (~/) ".dockerlib"
  mktree dockerlib
  _ <- sudolnsfn dockerlib "/var/lib/docker"
  return ()

installRust :: MonadIO io => App io
installRust = do
  (*!) $ aurInstall "rustup"
  prun' "rustup toolchain install stable"
  prun' "rustup default stable"
  prun' "rustup toolchain install nightly"

installJs :: MonadIO io => App io
installJs = do
  (*!) $ aurInstall' ["nodejs", "npm", "yarn"]
  prun' "yarn config set -- --emoji true"
  _ <- yarnInstallG "n"
  prun' "n latest"
  _ <- yarnInstallG' ["tern", "standard", "create-react-app", "js-beautify", "typescript", "tslint", "eslint-plugin-typescript", "typescript-eslint-parser"]
  return ()

installHaskell :: MonadIO io => App io
installHaskell = do
  (*!) $ aurInstall "stack-bin"
  (*!) $ prun "stack setup"
  (*!) $ stackInstall ["ghcid", "hindent", "stylish-haskell", "cabal-install", "hoogle", "hlint"]

installGo :: MonadIO io => App io
installGo = do
  (*!) $ aurInstall "go-pie"
  bin  <- (~/) "go/bin"
  src  <- (~/) "go/src"
  liftIO $ mktrees [bin, src]
  cmdE <- commandExists "golint"
  unless cmdE $ prun' "go get -u github.com/golang/lint/golint"

installGit :: MonadIO io => App io
installGit = do
  (*!) $ aurInstallF "./yaourt_git.txt"
  createGitIgnore
  where
    createGitIgnore = do
      (*!) $ prun "gibo update"
      res <- prun "gibo dump Emacs Vim JetBrains Ensime Tags Vagrant Windows macOS Linux Archives"
      case res of
        (Right gitignore) -> do
          gitingoreglobal <- (~/) ".gitignore.global"
          (*!) $ Tx.encodeUtf8 gitignore &>> gitingoreglobal
          append gitingoreglobal ".tern-project"
          append gitingoreglobal ".tern-port"
        e -> (*!) $ pure e

installCompton :: MonadIO io => App io
installCompton = do
  (*!) $ aurInstall' ["compton", "xorg-xwininfo"]
  beforeStartX <- (~/) ".before_startx"
  mktree beforeStartX
  (*!) $ "compton -c -i 0.9 -b &" &>> beforeStartX </> "run.sh"

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

(*#>) :: MonadIO io => String -> App io -> App io
(*#>) s' app = do
  liftIO . putStrLn $ s'
  printErrorAndContinue app

(*!>) :: MonadIO io => String -> AppT io a -> App io
(*!>) s' app = do
  liftIO . putStrLn $ "## " <> s'
  void app
