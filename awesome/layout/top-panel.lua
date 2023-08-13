local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local clickable_container = require('widget.material.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

local menu_button = require("widget.rofi")
local TagList = require('widget.tag-list')
local clock = require("widget.clock")
local systray = require("widget.systray")

local wifi = require("widget.wifi")
local bat = require("widget.battery")
local vol = require("widget.volume")
local blue = require("widget.bluetooth")


local empty_widget = wibox.widget {}

local TopPanel = function(s)

  local panel = wibox(
{
  ontop = true,
  screen = s,
  height = dpi(32),
  width = s.geometry.width,
  x = s.geometry.x,
  y = s.geometry.y,
  stretch = false,
  bg = '#00000000',
  fg = beautiful.fg_normal,
  struts = {
    top = dpi(32)
  }
})

panel:struts(
{
  top = dpi(32)
})

panel:setup {
  layout = wibox.layout.align.horizontal,
  {
    layout = wibox.layout.fixed.horizontal,
    menu_button,
    TagList(s),
  },
  {
    layout = wibox.layout.flex.horizontal,
    empty_widget,  -- Empty widget for center alignment
  },
  {
    layout = wibox.layout.fixed.horizontal,
    systray,
    blue,
    wifi,
    vol,
    bat,
    clock,
  }
}

  return panel
end

return TopPanel
