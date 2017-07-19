#!/bin/bash -e

installedExtensions=''
for extensionId in $(ls ~/.config/inox/Default/Extensions/ | grep -v 'Temp' | grep -v '^$'); do
  installedExtensions=$installedExtensions$extensionId'\n'
done

echo -e $installedExtensions > ~/dotfiles/config/inox/installedExtensions

#echo "Downloaded all extensions in $pwd, open chrome: chrome://extensions/ and manually install"

