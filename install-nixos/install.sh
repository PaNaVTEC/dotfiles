#!/usr/bin/env bash
set -e
set -x

# you only need to set this to the disk to want to install to
# IT WILL BE WIPED
rootdisk="${rootdisk:-NONE}";

# You can set the passphrase here (so you can view it in plaintext,
# but do not forget to remove it.
# TODO: check if this file is on a tempfs just like /etc/nixos/configuration.nix
passphrase="${passphrase:-NONE}";

help() {
  echo "\
Basic usage:
  rootdisk=/dev/disk/by-id/... $0

Options:
You can declare the following variables to change this script's behaviour:
    Required:
  rootdisk: path to the disk that will serve as root disk,
        will be wiped compeletely
  passphrase: the boot passphrase for your LUKS partition

    Example:
root@nixos:~$ export rootdisk=/dev/disk/by-id/wwn-0x50026b7275000ae3
root@nixos:~$ export passphrase=\"my secret passphrase\"
root@nixos:~$ $0
"

}

if [[ "$1" =~ --?h(elp)? ]];
then
  help;
  exit 0;
fi
# abort if no root disk is set
if [[ "${rootdisk}" == "NONE" ]]; then
  help;
  echo "please set rootdisk with: \`rootdisk=/dev/disk/by-id/disk_id_for_root_device $0\`" >&2;
  exit 1;
fi

if [[ "${passphrase}" == "NONE" ]]; then
  help;
  echo "please set passphrase with: \`passphrase=foo $0\`" >&2;
  exit 1;
fi

export rootdisk;
# absolute location for this script (directory the files are in)
export scriptlocation
scriptlocation="$(dirname "$(readlink -f "$0")")"

bash "$scriptlocation/partition_drive.sh"
bash "$scriptlocation/formatluks.sh"

nixos-generate-config --root /mnt

echo "Done!"
echo "Please check if if everything looks allright in all the files in /mnt/etc/nixos/"
echo "After that, run nixos-install, reboot your pc and remove your usb stick, you should be set :)"
exit 0
