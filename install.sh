#!/bin/bash

#------------------
#----- CONFIG -----
#------------------

#Variables
USERNAME="javier"
BLOAT=true

#If bloat is true you can finetune some apps to not install
CODE=true
GITHUB=true
DISCORD=true

CHROME=true

GIMP=true


STEAM=true


#Utilities

get_install_deb() {
    local APP="$1"
    local URL="$2"

    if [ "$APP" = true ]; then
        sudo wget -O "/home/$USERNAME/d.deb" "$URL"
        sudo dpkg -i "/home/$USERNAME/d.deb"
        sudo rm "/home/$USERNAME/d.deb"
    fi
}

#-------------------------
#----- END OF CONFIG -----
#-------------------------

#Start of the script

set -x

su -
apt-get install sudo
/sbin/adduser $USERNAME sudo

su - "$USERNAME" -c '

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install lightdm alacritty nemo code chromium awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome --ignore-missing -y

if [ "$BLOAT" = true ]; then
	get_install_deb $CODE "https://go.microsoft.com/fwlink/?LinkID=760868"
	get_install_deb $GITHUB "https://github.com/shiftkey/desktop/releases/download/release-3.2.7-linux2/GitHubDesktop-linux-amd64-3.2.7-linux2.deb"
	get_install_deb $DISCORD "deb https://discord.com/api/download?platform=linux&format=deb"
	get_install_deb $CHROME "https://www.google.com/chrome/next-steps.html?statcb=0&installdataindex=empty&defaultbrowser=0#"
	get_install_deb $STEAM "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	get_install_deb $GIMP "https://discord.com/api/download?platform=linux&format=deb"
fi

sudo systemctl start lightdm

sudo mkdir -p /home/$USERNAME/.config/rofi
sudo mkdir -p /home/$USERNAME/.config/nemo

sudo rm -p /home/$USERNAME/.config/rofi
sudo rm -p /home/$USERNAME/.config/nemo

sudo cp -r ./JDE/awesome /home/$USERNAME/.config
sudo cp -r ./JDE/rofi /home/$USERNAME/.config

sudo rm -r JDE'