local gears = require("gears")
local awful = require("awful")
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi

local menu_button = mat_icon_button(mat_icon(icons.planet, dpi(24)))
menu_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(awful.screen.focused().selected_tag.defaultApp, { tag = _G.mouse.screen.selected_tag, placement = awful.placement.bottom_right })
      end
    )
  )
)

return menu_button