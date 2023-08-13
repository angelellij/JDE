-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require('awful')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/wifi/icons/'
local interface = 'wlp3s0'
local connected = false
local essid = 'N/A'

local data_textbox = wibox.widget {
  font = 'Roboto 12',
  widget = wibox.widget.textbox
}

local function format_speed(speed_bytes)
  local megabytes = speed_bytes / (1024 * 1024)
  return string.format("%.0f", megabytes)
end

local widget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  widget_button,
  layout = wibox.layout.align.horizontal
}

local widget_with_margins = wibox.widget {
  {
      widget_button,
      top = dpi(8),
      bottom = dpi(8),
      left = dpi(8),
      right = dpi(4),
      widget = wibox.container.margin
  },
  layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(0), dpi(0), dpi(0), dpi(0)))
widget_button:buttons(
  gears.table.join(
    awful.button( {}, 1, nil, function() awful.spawn('wicd-client -n') end )
  )
)
-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {widget_button},
    mode = 'outside',
    align = 'right',
    timer_function = function()
      if connected then
        return 'Connected to ' .. essid
      else
        return 'Wireless network is disconnected'
      end
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'},
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8)
  }
)

local function grabText()
  if connected then
    awful.spawn.easy_async(
      'iw dev ' .. interface .. ' link',
      function(stdout)
        essid = stdout:match('SSID:(.-)\n')
        if (essid == nil) then
          essid = 'N/A'
        end
      end
    )
  end
end

watch(
  "awk 'NR==3 {printf \"%3.0f\" ,($3/70)*100}' /proc/net/wireless",
  5,
  function(_, stdout)
    local widgetIconName = 'wifi-strength'
    local wifi_strength = tonumber(stdout)
    if (wifi_strength ~= nil) then
      connected = true
      -- Update popup text
      local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
      widgetIconName = widgetIconName .. '-' .. wifi_strength_rounded
      widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '.svg')
      local download_speed = io.popen('cat /sys/class/net/' .. wired_interface .. '/statistics/rx_bytes'):read('*number')
      local upload_speed = io.popen('cat /sys/class/net/' .. wired_interface .. '/statistics/tx_bytes'):read('*number')

      
      data_textbox:set_text('Download: ' .. format_speed(download_speed))
    else
      connected = false
      widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '-off' .. '.svg')
      local download_speed = io.popen('cat /sys/class/net/' .. 'enp6s0' .. '/statistics/rx_bytes'):read('*number')
      local upload_speed = io.popen('cat /sys/class/net/' .. 'enp6s0' .. '/statistics/tx_bytes'):read('*number')
      data_textbox:set_text( format_speed(download_speed) .. ' / ' .. format_speed(upload_speed))  -- You need to implement `format_speed` function
    end
    if (connected and (essid == 'N/A' or essid == nil)) then
      grabText()
    end
    collectgarbage('collect')
  end,
  widget
)

widget:connect_signal(
  'mouse::enter',
  function()
    grabText()
  end
)

local net_widget =
  wibox.widget {
    widget_button,
    widget_with_margins,
    data_textbox,

    layout = wibox.layout.fixed.horizontal
  }

return net_widget
