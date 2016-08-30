 #!/usr/bin/env bash
set -e

#Fix trackpad issues
sudo cp 70-synaptics.conf /etc/X11/xorg.conf.d/

#Sets nvidia as default GPU
sudo pacman -S nvidia
sudo cp xorg.conf /etc/X11/xorg.conf
bash -c 'echo -e "xrandr --setprovideroutputsource modesetting NVIDIA-0 \nxrandr --auto" > /etc/X11/xinit/xinitrc.d/10-nvidia-load.sh'

#Fixes atheros 9285 connection drop problems
bash -c 'echo -e "options ath9k nohwcrypt=1 ps_enable=0" > /etc/modprobe.d/ath9k.conf'
sudo modprobe -r ath9k
sudo modprobe ath9k
