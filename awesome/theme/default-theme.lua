local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'



-- Colors Pallets

-- Primary
theme.primary = mat_colors.deep_orange

-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.grey

local awesome_overrides =
  function(theme)
  theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
  theme.icons = theme.dir .. '/icons/'

  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'

  -- theme.fg_normal = '#ffffffde'

  -- theme.fg_focus = '#e4e4e4'
  -- theme.fg_urgent = '#CC9393'
  -- theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.background.hue_800
  theme.bg_focus = '#00000000'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = '#133543'

  -- Borders

  theme.border_normal = theme.background.hue_800
  theme.border_focus = theme.primary.hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#23232300'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'

  -- Tasklist

  theme.tasklist_bg_normal = '#00000000'
  theme.tasklist_bg_focus = '#00000000'
  theme.tasklist_bg_urgent = '#00000000'
  theme.tasklist_fg_focus = '#00000000'
  theme.tasklist_fg_urgent = '#00000000'
  theme.tasklist_fg_normal = '#00000000'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = dpi(0)
  theme.border_focus = '#00000000'
  theme.border_normal = '#00000000'

end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}