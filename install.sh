#!/bin/bash
#variables
USERNAME="javier"
BLOAT=true

#If bloat is true you can finetune some apps to not install
CODE=true
DISCORD=true
GIMP=true

set -x

apt-get install sudo
/sbin/adduser $USERNAME sudo

apt-get update
apt-get upgrade
apt-get install lightdm alacritty nemo code chromium awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome --ignore-missing -y

if [ "$BLOAT" = true ]; then
	if [ "$CODE" = true ]; then
		wget -O ~/d.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
		dpkg -i ~/d.deb
		rm ~/d.deb
	fi

	if [ "$DISCORD" = true ]; then
		wget -O ~/d.deb https://discord.com/api/download?platform=linux&format=deb
		dpkg -i ~/d.deb
		rm ~/d.deb
	fi

	if [ "$GIMP" = true ]; then
		wget -O ~/d.deb https://discord.com/api/download?platform=linux&format=deb
		dpkg -i ~/d.deb
		rm ~/d.deb
	fi
fi
systemctl start lightdm

mkdir -p /home/$USERNAME/.config/rofi
mkdir -p /home/$USERNAME/.config/nemo

rm -p /home/$USERNAME/.config/rofi
rm -p /home/$USERNAME/.config/nemo

cp -r ./JDE/awesome /home/$USERNAME/.config
cp -r ./JDE/rofi /home/$USERNAME/.config

rm -r JDE