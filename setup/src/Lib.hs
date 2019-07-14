{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RankNTypes                 #-}

module Lib  where

import           Commands
import           Control.Monad.Except
import           Control.Monad.Logger
import           Data.Text             as Tx (Text, unpack)
import           Data.Text.Encoding    as Tx (encodeUtf8)
import           Network.HTTP.Client   (responseBody)
import           Network.Wreq          (get)
import           Turtle                (append, encodeString, mktree, touch,
                                        (</>))

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
  "i3"               *#> installi3
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
configurePacman = AppT $ do
  _ <- sudorm "/etc/pacman.conf"
  (*!) $ (`sudolnsfn` "/etc/pacman.conf") =<< pwd' "config/pacman/pacman.conf"
  (*!) pacmanSync
  (*!) $ prun "sudo pacman-key --init"
  (*!) $ prun "sudo pacman-key --populate archlinux"

updateMirrorList :: MonadIO io => App io
updateMirrorList = AppT $ do
  r <- liftIO $ get "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https"
  (*!) $ uncommentHash (responseBody r) &>> "/etc/pacman.d/mirrorlist"

installPacmanWrapper :: MonadIO io => App io
installPacmanWrapper = AppT $ do
  (*!) $ pacmanInstall' ["base-devel", "git", "wget", "yajl", "go-pie"]
  (*!) installYay
  void $ aurInstall "reflector"
  where
    installYay = runIfNotInstalled "yay" $ runpenv
        ["git clone --depth 1 https://aur.archlinux.org/yay.git /tmp/yay/"
        ,"cd /tmp/yay"
        ,"makepkg -si --noconfirm"
        ]

installPrinter :: MonadIO io => App io
installPrinter = AppT $ do
  (*!) $ aurInstall' ["cups", "nss-mdns", "gtk3-print-backends"]
  (*!) $ startService "orgs.cups.cupsd.service"
  (*!) $ startService "avahi-daemon.service"
  (*!) $ addCurrentUserToGroup "sys"

installBt :: MonadIO io => App io
installBt = AppT $ do
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
  installTmux
  installJs
  installHaskell
  installGo
  installRust
  installDocker
  installIntellij

installTmux :: MonadIO io => App io
installTmux = AppT $ do
  _ <- aurInstall' ["tmux", "tmux-tpm"]
  tpmAlreadyExists <- exitsOk "ls ~/tmux/plugins/tpm/"
  unless tpmAlreadyExists $ githubClone' "tmux-plugins/tpm" "~/.tmux/"

installIntellij :: MonadIO io => App io
installIntellij = AppT $ do
  (*!) $ "fs.inotify.max_user_watches = 524288" &>> "/etc/sysctl.d/99-sysctl.conf"
  prun' "sudo sysctl --system"

installDocker :: MonadIO io => App io
installDocker = AppT $ do
  (*!) $ sudormdir "/var/lib/docker"
  dockerlib <- (~/) ".dockerlib"
  mktree dockerlib
  _ <- sudolnsfn dockerlib "/var/lib/docker"
  return ()

installRust :: MonadIO io => App io
installRust = AppT $ do
  (*!) $ aurInstall "rustup"
  prun' "rustup toolchain install stable"
  prun' "rustup default stable"
  prun' "rustup toolchain install nightly"

installJs :: MonadIO io => App io
installJs = AppT $ do
  (*!) $ aurInstall' ["nodejs", "npm", "yarn"]
  prun' "yarn config set -- --emoji true"
  _ <- yarnInstallG "n"
  prun' "n latest"
  _ <- yarnInstallG' ["tern", "standard", "js-beautify"]
  _ <- yarnInstallG' ["create-react-app", "react-native-cli"]
  _ <- yarnInstallG' ["typescript", "tslint", "eslint-plugin-typescript", "typescript-eslint-parser"]
  _ <- yarnInstallG' ["purescript", "bower", "pulp"]
  return ()

installHaskell :: MonadIO io => App io
installHaskell = AppT $ do
  (*!) $ aurInstall "stack-bin"
  (*!) $ prun "stack setup"
  (*!) $ stackInstall ["ghcid", "hindent", "stylish-haskell", "cabal-install", "hoogle", "hlint"]

installGo :: MonadIO io => App io
installGo = AppT $ do
  (*!) $ aurInstall "go-pie"
  bin  <- (~/) "go/bin"
  src  <- (~/) "go/src"
  liftIO $ mktrees [bin, src]
  runIfNotInstalled' "golint" $ prun "go get -u github.com/golang/lint/golint"

installGit :: MonadIO io => App io
installGit = AppT $ do
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
installCompton = AppT $ do
  (*!) $ aurInstall' ["compton", "xorg-xwininfo"]
  beforeStartX <- (~/) ".before_startx"
  mktree beforeStartX
  (*!) $ "compton -c -i 0.9 -b &" &>> beforeStartX </> "run.sh"

installi3 :: MonadIO io => App io
installi3 = AppT $ do
  aurInstallF' "./yaourt_i3.txt"
  installLocker
  where
    installLocker =
      runIfNotInstalled' "gllock" $ do
        shaderPath <- (~/) ".gllock"
        runpenv
          [ "cd /tmp/gllock"
          , "mv config.mk config_orig.mk"
          , "cat config_orig.mk | grep -v '^FRGMNT_SHADER' | grep -v '^SHADER_LOCATION' > config.mk"
          , "echo -e \"FRGMNT_SHADER = crt.fragment.gls\nSHADER_LOCATION="<> encodeString  shaderPath <>"\n $(cat config.mk)\"> config.mk"
          , "sudo make clean install"
          ]

printErrorAndContinue :: MonadIO io => App io -> App io
printErrorAndContinue = ignoreExcept (putStrLn . Tx.unpack)

ignoreExcept :: MonadIO io => (Text -> IO ()) -> App io -> App io
ignoreExcept f' app' = lift $ do
  result <- runExceptT . unApp $ app'
  either
    (liftIO . f')
    pure
    result

breakIfFail :: MonadIO io => io ExecResult -> ExceptT Text io ()
breakIfFail res' = do
  _ <- lift (writeLogToFile res')
  void (liftEither =<< lift res')

(*!) :: MonadIO io => io ExecResult -> ExceptT Text io ()
(*!) = breakIfFail

(*#>) :: MonadIO io => String -> App io -> App io
(*#>) s' app = do
  liftIO . putStrLn $ s'
  printErrorAndContinue app

(*!>) :: MonadIO io => String -> io a -> io ()
(*!>) s' app
  = (liftIO . putStrLn $ "## " <> s') *> void app

writeLogToFile :: MonadIO io => io ExecResult -> io ExecResult
writeLogToFile iores = do
  result <- iores
  mktree "/tmp/setuplogs/"
  touch "/tmp/setuplogs/log.txt"
  liftIO . runFileLoggingT "/tmp/setuplogs/log.txt"
    $ do
      case result of
        (Right r) -> logInfoN r
        (Left l)  -> logErrorN l
      pure result
