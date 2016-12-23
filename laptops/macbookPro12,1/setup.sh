yaourt -S --noconfirm 
	xf86-input-mtrack-git \
	kbdlight

#Fixes dpi of i3 in general
bash -c 'echo -e "xrandr --dpi 160\nxrdb -merge ~/.Xresources" >> ~/.before_startx/run.sh'
chmod a+x ~/.before_startx/run.sh

