-- ~/.config/awesome/widgets/desktop_clock_widget.lua

local wibox = require("wibox")

local clock_widget = wibox.widget.textclock("%H:%M")

-- Set up a timer to update the clock widget periodically
local clock_update_timer = timer({ timeout = 60 })
clock_update_timer:connect_signal("timeout", function()
    clock_widget:set_text(os.date("%H:%M"))
end)
clock_update_timer:start()
