local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require('beautiful')
local clickable_container = require('widget.material.clickable-container')
local dpi = beautiful.xresources.apply_dpi

local PATH_TO_ICONS = os.getenv('HOME').. '/.config/awesome/widget/wifi/icons/'
local icon_path = PATH_TO_ICONS .. 'wifi.svg'

-- Define paths and commands
local clic_command = "nm-connection-editor"

-- Determine whether to use WiFi or wired interface
local interface_name = "wlan0"  -- Replace with your actual WiFi interface name
local wifi_connection = false

local function format_speed(speed_bytes)
  local megabytes = speed_bytes / (1024 * 1024)
  return string.format("%.0f", megabytes)
end

-- Function to get the name of the wired network interface
local function getWiredInterfaceName()
  local interfaces = io.popen("ip link | awk -F': ' '/^[0-9]+: [^lo]/ {print $2}'"):read("*a")
  local interface_name = interfaces:match("%S+")
  return interface_name
end

interface_name = getWiredInterfaceName()

-- Create the icon widget
local icon = wibox.widget {
  {
      widget = wibox.widget.imagebox,
      image = icon_path,
      resize = true,
  },
  widget = wibox.container.margin,
}

-- Create the text widget
local space = wibox.widget {
  id = "space",
  widget = wibox.widget.textbox,
  text = "  ",
  align = "center",
  font = 'Roboto 12'
}

-- Create the text widget
local text_widget = wibox.widget {
  id = "text",
  widget = wibox.widget.textbox,
  text = "N/A",
  align = "center",
  font = 'Roboto 12'
}

-- Combine the icon and text widgets
local wifi_widget = wibox.widget {
  icon,
  space,
  text_widget,
  layout = wibox.layout.fixed.horizontal
}

-- Add tooltip on hover
awful.tooltip {
    objects = { wifi_widget },
    mode = "outside",
    timer_function = function()
      local tooltip_text = ""

      if wifi_connection then
          awful.spawn.easy_async("bash -c 'iwgetid -r'", function(stdout)
              local current_wifi = stdout:gsub("\n", "")
              local available_wifis = "Available WiFi List"  -- Replace with actual available WiFi list

              tooltip_text = "Current: " .. current_wifi .. "\n" .. available_wifis
          end)
      else
          local wired_info = "Wired Network"
          tooltip_text = wired_info
      end

      return tooltip_text
    end,
    fg = '#ffffff'
}

-- Set up click action
wifi_widget:connect_signal("button::release", function()
    awful.spawn(clic_command)
end)

-- Create a timer to update the text
local timer = gears.timer {
  timeout = 30,
  call_now = true,
  autostart = true,
  callback = function()
    local download_speed = io.popen('cat /sys/class/net/' .. interface_name .. '/statistics/rx_bytes'):read('*number')
    local upload_speed = io.popen('cat /sys/class/net/' .. interface_name .. '/statistics/tx_bytes'):read('*number')
    text_widget:set_text( format_speed(download_speed) .. ' / ' .. format_speed(upload_speed))
  end
}

local wifi_container = clickable_container(wibox.container.margin(wifi_widget, dpi(8), dpi(8), dpi(8), dpi(8)))
return wifi_container
