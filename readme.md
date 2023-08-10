Work in progress...

## **What is JDE**

This is just a desktop environment i made for myself to install on any debian minimal installation. It uses awesome as a WM.

## **Installation**

When doing nano on install.sh change the username variable to your username.

```
#Get SUDO and GIT
su -
apt-get install sudo
/sbin/adduser $USERNAME sudo
apt install git
git clone https:github.com/angelellij/JDE

#Install the DE
nano ./JDE/install.sh
chmod +x ./JDE/install.sh
./JDE/install.sh
```
