local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local clickable_container = require('widget.material.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

local menu_button = require("layout.menu_button")
local TagList = require('widget.tag-list')
local clock = require("layout.clock")
local systray = require("layout.systray")
local layout_icon = require("layout.layout_button")

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
    -- layout_icon(s),
    clock,
  }
}

  return panel
end

return TopPanel
