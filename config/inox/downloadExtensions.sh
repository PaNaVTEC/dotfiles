#!/bin/bash -e

installationDirectory=~/Downloads
for extensionId in $(cat ~/dotfiles/config/inox/installedExtensions | grep -v '^$'); do
  echo "Downloading $extensionId"
  (cd $installationDirectory && downloadExtensionInox.sh $extensionId)
done

echo "Downloaded all extensions in $installationDirectory, open chrome: chrome://extensions/ and manually install"

