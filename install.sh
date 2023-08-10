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

su -
apt-get install sudo
/sbin/adduser $USERNAME sudo

su $USERNAME

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install lightdm alacritty nemo code chromium awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome --ignore-missing -y

if [ "$BLOAT" = true ]; then
	if [ "$CODE" = true ]; then
		sudo wget -O /home/$USERNAME/d.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
		sudo dpkg -i /home/$USERNAME/d.deb
		sudo rm /home/$USERNAME/d.deb
	fi

	if [ "$DISCORD" = true ]; then
		sudo wget -O /home/$USERNAME/d.deb https://discord.com/api/download?platform=linux&format=deb
		sudo dpkg -i /home/$USERNAME/d.deb
		sudo rm /home/$USERNAME/d.deb
	fi

	if [ "$CHROME" = true ]; then
		sudo wget -O /home/$USERNAME/d.deb https://www.google.com/chrome/next-steps.html?statcb=0&installdataindex=empty&defaultbrowser=0#
		sudo dpkg -i /home/$USERNAME/d.deb
		sudo rm /home/$USERNAME/d.deb
	fi
	
	if [ "$STEAM" = true ]; then
		sudo wget -O /home/$USERNAME/d.deb https://cdn.akamai.steamstatic.com/client/installer/steam.deb
		sudo dpkg -i /home/$USERNAME/d.deb
		sudo rm /home/$USERNAME/d.deb
	fi
	


	if [ "$GIMP" = true ]; then
		sudo wget -O /home/$USERNAME/d.deb https://discord.com/api/download?platform=linux&format=deb
		sudo dpkg -i /home/$USERNAME/d.deb
		sudo rm /home/$USERNAME/d.deb
	fi
fi
sudo systemctl start lightdm

sudo mkdir -p /home/$USERNAME/.config/rofi
sudo mkdir -p /home/$USERNAME/.config/nemo

sudo rm -p /home/$USERNAME/.config/rofi
sudo rm -p /home/$USERNAME/.config/nemo

sudo cp -r ./JDE/awesome /home/$USERNAME/.config
sudo cp -r ./JDE/rofi /home/$USERNAME/.config

sudo rm -r JDE