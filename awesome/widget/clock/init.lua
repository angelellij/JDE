local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local textclock = wibox.widget.textclock('<span font="Roboto Mono 12">%d/%m | %H:%M</span>')

local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  week_numbers = true
})
month_calendar:attach(textclock)

local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

return clock_widget