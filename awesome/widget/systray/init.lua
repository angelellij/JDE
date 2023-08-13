local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local systray = wibox.widget.systray({
    base_size = dpi(20),
    widget_function = function(_, icon)
        if not is_blueman(icon) then
            return wibox.widget {
                icon,
                widget = wibox.container.margin,
                left = dpi(3),
                right = dpi(3),
                top = dpi(6),
                bottom = dpi(3),
                opacity = 0
            }
        end
    end,
    filter = filter_blueman_icons
})

local function is_blueman(icon)
    return icon.name == 'blueman'  -- Replace 'blueman' with the actual identifier
end

systray:set_horizontal(true)
systray:set_base_size(20)
systray = wibox.container.background(systray, "#000000")
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