yaourt --noconfirm -S  acpilight

# Acpi light permissions
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules

ln -sfn ~/dotfiles/laptops/x230/.env.sh ~/.env.sh

# Laptop mode: https://www.ostechnix.com/improve-laptop-battery-performance-linux/
