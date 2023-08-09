#!/bin/bash
#variables
USERNAME="javier"
BLOAT=true

#If bloat is true you can finetune some apps to not install
CODE=true
CHROME=true

GIMP=true

DISCORD=true
STEAM=true



set -x

apt-get install sudo
/sbin/adduser $USERNAME sudo

apt-get update
apt-get upgrade
apt-get install lightdm alacritty nemo code chromium awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome --ignore-missing -y

if [ "$BLOAT" = true ]; then
	if [ "$CODE" = true ]; then
		wget -O /home/$USERNAME/d.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
		dpkg -i /home/$USERNAME/d.deb
		rm /home/$USERNAME/d.deb
	fi

	if [ "$DISCORD" = true ]; then
		wget -O /home/$USERNAME/d.deb https://discord.com/api/download?platform=linux&format=deb
		dpkg -i /home/$USERNAME/d.deb
		rm /home/$USERNAME/d.deb
	fi

	if [ "$CHROME" = true ]; then
		wget -O /home/$USERNAME/d.deb https://www.google.com/chrome/next-steps.html?statcb=0&installdataindex=empty&defaultbrowser=0#
		dpkg -i /home/$USERNAME/d.deb
		rm /home/$USERNAME/d.deb
	fi
	
	if [ "$STEAM" = true ]; then
		wget -O /home/$USERNAME/d.deb https://cdn.akamai.steamstatic.com/client/installer/steam.deb
		dpkg -i /home/$USERNAME/d.deb
		rm /home/$USERNAME/d.deb
	fi
	


	if [ "$GIMP" = true ]; then
		wget -O /home/$USERNAME/d.deb https://discord.com/api/download?platform=linux&format=deb
		dpkg -i /home/$USERNAME/d.deb
		rm /home/$USERNAME/d.deb
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