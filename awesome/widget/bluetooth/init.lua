local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')

local PATH_TO_ICONS = os.getenv('HOME') .. '/.config/awesome/widget/bluetooth/icons/'
local dpi = require('beautiful').xresources.apply_dpi

local bluetooth_widget =
  wibox.widget {
    {
      id = 'icon',
      image = PATH_TO_ICONS .. 'bluetooth.svg',
      resize = true,
      widget = wibox.widget.imagebox
    },
    layout = wibox.layout.fixed.horizontal
}

local bluetooth = clickable_container(wibox.container.margin(bluetooth_widget, dpi(8), dpi(8), dpi(8), dpi(8)))

bluetooth:buttons(
  gears.table.join( awful.button( {}, 1, nil, function() awful.spawn('blueman-manager') end ) )
)

return bluetooth
