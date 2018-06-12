yaourt --noconfirm -S acpilight

# Acpi light permissions
sudo cp 90-backlight.rules /etc/udev/rules.d/
sudo cp 50-btadapter-no-powersave.rules /etc/udev/rules.d/

ln -sfn ~/dotfiles/laptops/x230/.env.sh ~/.env.sh

# Laptop mode: https://www.ostechnix.com/improve-laptop-battery-performance-linux/
