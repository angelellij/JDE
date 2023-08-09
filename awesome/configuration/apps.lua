local filesystem = require('gears.filesystem')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'rofi -show drun'

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'alacritty',
    rofi = rofi_command,
    quake = 'alacritty',
    screenshot = 'flameshot gui -p ~/Pictures/Screenshots/',
    browser = 'google-chrome',
    editor = 'code',
    social = 'discord',
    game = rofi_command,
    files = 'dolphin',
    music = 'youtubemusic' 
  },

  -- List of apps to start once on start-up
  run_on_start_up = {
    --javier
    'bt-edifier', 
    'discord --silent',
    -- 'compton --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
    -- 'nm-applet --indicator', -- wifi
    'pnmixer', -- shows an audiocontrol applet in systray when installed.
    -- 'blueberry-tray', -- Bluetooth tray icon
    'numlockx on', -- enable numlock
    -- '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    -- 'xfce4-power-manager', -- Power manager

    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/awspawn', -- Spawn "dirty" apps that can linger between sessions


  }
}
