#!/bin/bash

#------------------
#----- CONFIG -----
#------------------

#Variables
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
        sudo wget -O ~/d.deb "$URL"
        sudo dpkg -i ~/d.deb
        sudo rm ~/d.deb
    fi
}

#-------------------------
#----- END OF CONFIG -----
#-------------------------

#Start of the script

set -x

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install lightdm alacritty nemo awesome fonts-roboto rofi compton lxappearance xbacklight flameshot xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome -y

if [ "$BLOAT" = true ]; then
	get_install_deb $CODE "https://go.microsoft.com/fwlink/?LinkID=760868"
	get_install_deb $GITHUB "https://github.com/shiftkey/desktop/releases/download/release-3.2.7-linux2/GitHubDesktop-linux-amd64-3.2.7-linux2.deb"
	get_install_deb $DISCORD "deb https://discord.com/api/download?platform=linux&format=deb"
	get_install_deb $CHROME "https://www.google.com/chrome/next-steps.html?statcb=0&installdataindex=empty&defaultbrowser=0#"
	get_install_deb $STEAM "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	get_install_deb $GIMP "https://discord.com/api/download?platform=linux&format=deb"
fi

sudo mkdir -p ~/.config/rofi
sudo mkdir -p ~/.config/nemo

sudo rm -p ~/.config/rofi
sudo rm -p ~/.config/nemo

sudo cp -r ./JDE/awesome ~/.config
sudo cp -r ./JDE/rofi ~/.config

sudo rm -r JDE

sudo systemctl start lightdm