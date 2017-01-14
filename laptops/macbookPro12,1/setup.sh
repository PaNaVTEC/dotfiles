yaourt -R xorg-xbacklight
yaourt -S --noconfirm 
	xf86-input-mtrack-git \   # Touchpad
	kbdlight \ 		  # keyboard brightness
	bcwc-pcie-git \		  # webcam
	acpilight \		  # screen brightness
	mbpfan-git 		  # fan 

# Fix wifi connection flickering
sudo cp 40-ipv6.conf /etc/sysctl.d

# Acpi light permissions
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules

#Fixes dpi of i3
bash -c 'echo -e "xrandr --dpi 160\nxrdb -merge ~/.Xresources" >> ~/.before_startx/run.sh'
chmod a+x ~/.before_startx/run.sh
bash -c 'echo -e "Xft.dpi: 160.0" >> ~/.Xresources'

#Fns instead of media keys
sudo cp apple.conf /etc/modprobe.d/apple.conf

#Enable fan service
sudo systemctl enable mbpfan.service
sudo systemctl start mbpfan.service
