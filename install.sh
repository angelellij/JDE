#!/bin/bash
apt-get update
apt-get upgrade
apt install lightdm alacritty nemo code google-chrome-stable awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome -y
systemctl start lightdm

mkdir -p ~/.config/rofi

rm ./.config/awesome
rm ./.config/rofi

cp -r ./JDE/awesome ./.config
cp -r ./JDE/rofi ./.config
