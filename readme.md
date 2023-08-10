Work in progress...

## **What is JDE**

This is just a desktop environment i made for myself to install on any debian minimal installation. It uses awesome as a WM.

## **Installation**

Run the following commands after installing a minimal debian installation. BEWARE: Running this on an already running app may break some functionality.

```
#Get SUDO and GIT
su -
apt-get install sudo
/sbin/adduser $USERNAME sudo
apt install git
git clone https:github.com/angelellij/JDE

#Install the DE
su $USERNAME
cd ~/ #Or cd to /home/$USERNAME
sudo nano ./JDE/install.sh #If you want to toggle config
sudo chmod +x ./JDE/install.sh
./JDE/install.sh #No sudo!!!
```
