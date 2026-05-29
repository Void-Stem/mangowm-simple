#!/bin/bash
set -e

sudo pacman -S --needed git base-devel --noconfirm

echo "installing yay"
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi
echo "yay installed"

echo "installing MangoWm"
yay -S mangowm-git --noconfirm

echo "installing basic apps/tools"
yay -S wpgtk --noconfirm
sudo pacman -S --needed nano thunar rofi-wayland kitty lxappearance --noconfirm

echo "creating ~/Pictures"
mkdir -p ~/Pictures
echo "copying wallpaper"
cp ~/mangowm-simple/wallpaper.png ~/Pictures/wallpaper.png

echo "creating ~/.config/mango"
mkdir -p ~/.config/mango
echo "copying mango config"
cp ~/mangowm-simple/configs/mangowm.conf ~/.config/mango

echo "creating ~/.config/kitty"
mkdir -p ~/.config/kitty
echo "copying kitty.conf"
cp ~/mangowm-simple/configs/kitty.conf ~/.config/kitty.conf

echo "creating ~/.config/rofi"
mkdir -p ~/.config/rofi
echo "copying rofi.rasi"
cp ~/mangowm-simple/configs/rofi.rasi ~/.config/config.rasi

read -r -p "install candy icons and create gtk theme from wallpaper.png? [y/N]: " choice

case "$choice" in
    y|Y)
        echo "installing icons and creating gtk theme"
        yay -S --needed candy-icons-git --noconfirm
	wpg -a || echo "wpgtk already initialized or skipped"
	wpg -s ~/Pictures/wallpaper.png
	wpg -m
        ;;
    *)
        echo "skipping candy icons and gtk theme"
        ;;
esac

echo "you can manage your icons and gtk settings in lxappearance"
echo "use sudo reboot to complete installation"
