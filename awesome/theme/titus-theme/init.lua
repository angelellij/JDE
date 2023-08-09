local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local gears = require("gears")
local awful = require("awful")

local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto Medium 11'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
theme.primary.hue_500 = '#11535c'

-- Accent
theme.accent = mat_colors.pink

-- Background
for s = 1, screen.count() do
  gears.wallpaper.maximized("../wall.svg", s, true)
end

theme.border_normal = "#000000"  -- Default border color
theme.border_focus = "#FF0000"   -- Border color for focused windows
theme.border_opacity = 0.8       -- Opacity of window borders


local awesome_overrides = function(theme)
  --
end



return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
