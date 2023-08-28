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

get_install_apt() {
    local APP="$1"

    if [ "$APP" == false ]; then
        echo "Skipping."
    else
        sudo apt install $APP
    fi
}

rm_desk() {
    local DESK="$1"
    if [ -e "/usr/share/applications/${DESK}.desktop" ]; then
        sudo rm "/usr/share/applications/${DESK}.desktop"
    fi
}

update_config_files(){
    local APP="$1"
    if [ -d ~/.config ]; then
        rm -r ~/.config/"${APP}"
    fi
    mkdir -p ~/.config/"${APP}"
    cp -r ./JDE/"${APP}" ~/.config
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
sudo apt-get install lightdm -f                     #Login Screen
sudo apt-get install alacritty -f                   #Terminal
sudo apt-get install nemo -f                        #Files
sudo apt-get install awesome -f                     #Window Manager
sudo apt-get install fonts-roboto -f                #Font
sudo apt-get install rofi -f                        #Apps menu
sudo apt-get install picom -f                       #Compositor
sudo apt-get install lxappearance -f                #Theme manager
sudo apt-get install xbacklight -f                  
sudo apt-get install flameshot -f                   #Screenshot taker
sudo apt-get install xfce4-power-manager -f         #Power manager for laptops
sudo apt-get install pavucontrol -f                 #Audio GUI
sudo apt-get install blueman-manager -f             #Bluetooth GUI
sudo apt-get install nm-connection-editor -f       #Network mangaer 
sudo apt-get install policykit-1-gnome -f           #PolKit
sudo apt-get --fix-broken install                   #Install dependecies that were not installed

echo "-------------------------------"
echo "Installing optional packages..."
echo "-------------------------------"

if [ "$BLOAT" = true ]; then
	get_install_deb $CODE "https://go.microsoft.com/fwlink/?LinkID=760868"
	get_install_deb $GITHUB "https://github.com/shiftkey/desktop/releases/download/release-3.2.7-linux2/GitHubDesktop-linux-amd64-3.2.7-linux2.deb"
	get_install_deb $DISCORD "https://discord.com/api/download?platform=linux&format=deb"
	get_install_deb $CHROME "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	get_install_deb $STEAM "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	get_install_apt $GIMP
fi

sudo apt-get --fix-broken install

if [ ! -d ~/.config ]; then
    mkdir -p ~/.config/"${APP}"
fi
sudo chown -R $USER:$USER ~/.config

echo "-------------------------------"
echo "        DE Config files        "
echo "-------------------------------"

update_config_files "rofi"              #Apps menu
update_config_files "picom"             #Compositor
update_config_files "awesome"           #Window Manager

#remove unnecesary .desktops
#The apps are necessary but users are not going to manually run them
echo "-------------------------------"
echo " Removing unnecesary .desktop  "
echo "-------------------------------"

rm_desk "yelp"                      #Help app
rm_desk "picom"                     #Compositor
rm_desk "debian-uxterm"             #Terminal
rm_desk "debian-xterm"              #Terminal
rm_desk "zutty"                     
rm_desk "compton"                   #Compositor
rm_desk "org.gnome.FileRoller"      #Archive Manager (zip, tar)

#endscript

echo "-------------------------------"
echo "       Finishing touches       "
echo "-------------------------------"

sudo rm -r JDE

sudo systemctl start lightdm
sudo systemctl restart lightdm
