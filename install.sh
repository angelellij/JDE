#!/bin/bash

#------------------
#----- CONFIG -----
#------------------

#Variables
BLOAT=true

#If bloat is true you can finetune some apps to not install
CODE="code"
GITHUB="github-desktop"
DISCORD="discord"

CHROME="google-chrome-stable"

STEAM="steam"
GIMP=false


#Utilities

get_install_deb() {
    local APP="$1"
    local URL="$2"

    if [ "$APP" == false ]; then
        echo "Skipping."
    elif dpkg-query -W -f='${Status}' "$APP" 2>/dev/null | grep -q "installed"; then
        echo "$APP is already installed."
    else
        sudo wget -O ~/d.deb "$URL"
        sudo dpkg -i ~/d.deb
        sudo rm ~/d.deb
    fi
}

rm_desk() {
    local DESK="$1"
    sudo rm "/usr/share/applications/${DESK}.desktop"
}

update_config_files(){
    local APP="$1"

    sudo mkdir -p "~/.config/${APP}"
    sudo rm -r "~/.config/${APP}"
    sudo mkdir -p "~/.config/${APP}"
    sudo cp -r "./JDE/${APP}" ~/.config
}

#-------------------------
#----- END OF CONFIG -----
#-------------------------

#Start of the script
echo "--------------------------------"
echo "Installing necessary packages..."
echo "--------------------------------"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install lightdm -f 
sudo apt-get install alacritty -f 
sudo apt-get install nemo -f
sudo apt-get install awesome -f
sudo apt-get install fonts-roboto -f
sudo apt-get install rofi -f
sudo apt-get install compton -f
sudo apt-get install lxappearance -f
sudo apt-get install xbacklight -f
sudo apt-get install flameshot -f
sudo apt-get install xfce4-power-manager -f
sudo apt-get install pnmixer -f
sudo apt-get install network-manager-gnome -f
sudo apt-get install policykit-1-gnome -f
sudo apt-get --fix-broken install

echo "-------------------------------"
echo "Installing optional packages..."
echo "-------------------------------"

if [ "$BLOAT" = true ]; then
	get_install_deb $CODE "https://go.microsoft.com/fwlink/?LinkID=760868"
	get_install_deb $GITHUB "https://github.com/shiftkey/desktop/releases/download/release-3.2.7-linux2/GitHubDesktop-linux-amd64-3.2.7-linux2.deb"
	get_install_deb $DISCORD "https://discord.com/api/download?platform=linux&format=deb"
	get_install_deb $CHROME "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	get_install_deb $STEAM "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	# get_install_deb $GIMP "https://discord.com/api/download?platform=linux&format=deb"
fi

sudo apt-get --fix-broken install

echo "-------------------------------"
echo "        DE Config files        "
echo "-------------------------------"

update_config_files "rofi"
update_config_files "picom"
update_config_files "awesome"

#remove unnecesary .desktops
echo "-------------------------------"
echo " Removing unnecesary .desktop  "
echo "-------------------------------"

rm_desk "yelp"
rm_desk "picom"
rm_desk "debian-uxterm"
rm_desk "debian-xterm"
rm_desk "zutty"
rm_desk "compton"
rm_desk "org.gnome.FileRoller"

#endscript

echo "-------------------------------"
echo "       Finishing touches       "
echo "-------------------------------"

sudo rm -r JDE

sudo systemctl start lightdm
sudo systemctl restart lightdm