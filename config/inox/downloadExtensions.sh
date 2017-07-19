#!/bin/bash -e

installationDirectory=~/Downloads
for extensionId in $(ls ~/dotfiles/config/inox/installedExtensions | grep -v '^$'); do
  (cd $installationDirectory && ./downloadExtensions.sh $extensionId)
done

echo "Downloaded all extensions in $installationDirectory, open chrome: chrome://extensions/ and manually install"

