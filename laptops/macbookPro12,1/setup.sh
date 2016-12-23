yaourt -S --noconfirm 
	xf86-input-mtrack-git \
	kbdlight \
	broadcom-wl

#Fixes dpi of i3
bash -c 'echo -e "xrandr --dpi 160\nxrdb -merge ~/.Xresources" >> ~/.before_startx/run.sh'
chmod a+x ~/.before_startx/run.sh
bash -c 'echo -e "Xft.dpi: 160.0" >> ~/.Xresources'

#Fns instead of media keys
sudo cp apple.conf /etc/modprobe.d/apple.conf
