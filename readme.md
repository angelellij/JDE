Work in progress...

## **What is JDE**

This is just a desktop environment I made for myself to install on any debian minimal installation. It uses i3 as a WM.

## **Installation**

Run the following commands after installing a minimal debian installation. BEWARE: Running this on an already running app will probably break some functionality.

```
#Get SUDO and GIT
su -
apt-get install sudo
/sbin/adduser $USERNAME sudo
apt install git

#Install the DE
su $USERNAME
cd ~/ #Or cd to /home/$USERNAME
sudo git clone https:github.com/angelellij/JDE
sudo nano ./JDE/install.sh #If you want to toggle config
sudo chmod +x ./JDE/install.sh
./JDE/install.sh #No sudo!!!
```
