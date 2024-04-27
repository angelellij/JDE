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
FIREFOX="firefox-esr"

STEAM="steam"
GIMP="gimp"
OBS="obs-studio"



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


update_config_files(){
    local APP="$1"
    if [ -d ~/.config ]; then
        rm -r ~/.config/"${APP}"
    fi
    mkdir -p ~/.config/"${APP}"
    cp -r ./JDE/"${APP}" ~/.config
}

add_desktop_file(){
    local APP="$1"
    sudo cp -r ./JDE/"${APP}".desktop /usr/share/applications
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
sudo apt-get install -y xfce4 xfce4-goodies         #Xfce Utilities
sudo apt-get install lightdm -f                     #Login Screen
sudo apt-get install alacritty -f                   #Terminal
sudo apt-get install nemo -f                        #Files
sudo apt-get install i3 -f                          #Window Manager
sudo apt-get install fonts-roboto -f                #Font
sudo apt-get install rofi -f                        #Apps menu
# sudo apt-get install picom -f                       #Compositor
sudo apt-get install lxappearance -f                #Theme manager
sudo apt-get install xbacklight -f                  #Brightess
sudo apt-get install flameshot -f                   #Screenshot taker
sudo apt-get install xfce4-power-manager -f         #Power manager for laptops
sudo apt-get install pavucontrol -f                 #Audio GUI
sudo apt-get install blueman-manager -f             #Bluetooth GUI
sudo apt-get install nm-connection-editor -f        #Network manager 
sudo apt-get install policykit-1-gnome -f           #PolKit
sudo apt-get install dunst -f                       #Notifications
sudo apt-get install wmctrl -f                      #Utility

echo "-------------------------------"
echo "Installing dependencies.."
echo "-------------------------------"

sudo apt-get --fix-broken install                   #Install dependecies that were not installed

echo "-------------------------------"
echo " Remove unnecesary.."
echo "-------------------------------"

sudo apt remove xfce4-notifyd
sudo apt autoremove

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
    get_install_apt $FIREFOX
fi

echo "-------------------------------"
echo "Installing dependencies.."
echo "-------------------------------"
sudo apt-get --fix-broken install

if [ ! -d ~/.config ]; then
    mkdir -p ~/.config/"${APP}"
fi
sudo chown -R $USER:$USER ~/.config

echo "-------------------------------"
echo "        DE Config files        "
echo "-------------------------------"

update_config_files "dunst"          #Notifications
update_config_files "i3"             #Window Manager
update_config_files "rofi"           #Apps menu

echo "-------------------------------"
echo " .sh files add exec permission "
echo "-------------------------------"

add_exec_permission_to_sh() {
    local directory="$1"

    # Check if directory argument is provided
    if [ -z "$directory" ]; then
        echo "Usage: add_exec_permission_to_sh <directory>"
        return 1
    fi

    # Check if directory exists
    if [ ! -d "$directory" ]; then
        echo "Directory '$directory' not found."
        return 1
    fi

    # Add executable permission to .sh files in the directory recursively
    find "$directory" -type f -name "*.sh" -exec chmod +x {} \;

    echo "Executable permission added to .sh files in '$directory'."
}

add_exec_permission_to_sh ".config/rofi"
add_exec_permission_to_sh ".config/dunst"

echo "-------------------------------"
echo "         Add .desktop          "
echo "-------------------------------"

add_desktop_file "Pavucontrol"
add_desktop_file "RofiWifi"

echo "-------------------------------"
echo " NoDisplay unnecesary .desktop "
echo "-------------------------------"

input_file="JDE/NoDisplay.txt" #.desktop files to not display on rofi menu

add_NoDisplay() {
    local desktop_file="$1"

    if grep -q "^Rofi=true" "$desktop_file"; then
        sed -i 's/^Rofi=true/Rofi=false/' "$desktop_file"
        echo "Changed Rofi from true to false in $desktop_file"
    elif ! grep -q "^Rofi=false" "$desktop_file"; then
        echo "Rofi=false" >> "$desktop_file"
        echo "Added Rofi=false to $desktop_file"
    else
        echo "Rofi=false already exists in $desktop_file"
    fi
}

if [ ! -f "$input_file" ]; then
    echo "Input file $input_file not found"
    exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do
    desktop_file="/usr/share/applications/$line"
    if [ -f "$desktop_file" ]; then
        add_NoDisplay "$desktop_file"
    else
        echo "$desktop_file not found"
    fi
done < "$input_file"

echo "-------------------------------"
echo "       Finishing touches       "
echo "-------------------------------"

# sudo rm -r JDE

xsetroot -solid "#202124"

sudo systemctl start lightdm
sudo systemctl restart lightdm
