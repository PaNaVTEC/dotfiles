yin bumblebee nvidia nvidia-utils bbswitch mesa xf86-video-intel

ln -sfn ~/dotfiles/laptops/ps42/xorg.conf.nvidia /etc/bumblebee/xorg.conf.nvidia
ln -sfn ~/dotfiles/laptops/ps42/backlight.conf /etc/X11/xorg.conf.d/backlight.conf

gpasswd -a panavtec bumblebee
systemctl enable bumblebee.service
