local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local systray = wibox.widget.systray( )

systray:set_horizontal(true)
systray:set_base_size(20)
systray = wibox.container.background(systray, "#ff0000")
-- systray.mywibox = awful.wibar({ opacity = 0.5})

-- systray = wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3))

local systray = wibox.widget {
    systray,
    widget = wibox.container.margin,
    left = dpi(3),
    right = dpi(3),
    top = dpi(6),
    bottom = dpi(3),
    opacity = 0
}

return systray