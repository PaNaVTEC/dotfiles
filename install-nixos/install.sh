#!/usr/bin/env bash
set -e
set -x

# you only need to set this to the disk to want to install to
# IT WILL BE WIPED
rootdisk="${rootdisk:-NONE}";

help() {
  echo "\
Basic usage:
  rootdisk=/dev/disk/by-id/... $0

Options:
You can declare the following variables to change this script's behaviour:
    Required:
  rootdisk: path to the disk that will serve as root disk,
        will be wiped compeletely

    Example:
root@nixos:~$ export rootdisk=/dev/disk/by-id/wwn-0x50026b7275000ae3
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

export rootdisk;
# absolute location for this script (directory the files are in)
export scriptlocation
scriptlocation="$(dirname "$(readlink -f "$0")")"

bash "$scriptlocation/partition_drive.sh"
bash "$scriptlocation/formatluks.sh"

nixos-generate-config --root /mnt

echo "Done!"
echo "Manual STEPS, if not it will not boot:"
echo "edit /mnt/etc/nixos/configuration.nix and add a section:"
echo 'initrd.luks.devices = {'
echo '  root = {'
echo '    device = "/dev/disk/by-uuid/YOUR DISK UUID (NOT PARTUUID)";'
echo '    preLVM = true;'
echo '    allowDiscards = true;'
echo '  };'
echo '};'
echo '\n'
echo 'To get your UUID do "blkid" and get the uuid from the partition where the typpe is crypto_LUKS'
echo 'After that, run install-nixos and you should be done'

exit 0
