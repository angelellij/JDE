local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon_button = require('widget.material.icon-button')
local icons = require('theme.icons')
local spawn = require('awful.spawn')
local gears = require('gears')
local awful = require('awful')
local watch = require('awful.widget.watch')
local clickable_container = require('widget.material.clickable-container')

local space = require('widget.space')

-- Define paths and commands
local clic_command = "pavucontrol"
local PATH_TO_ICONS = os.getenv('HOME') .. '/.config/awesome/widget/volume/icons/'
local dpi = require('beautiful').xresources.apply_dpi

local percentage_textbox = wibox.widget {
  font = 'Roboto 12',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

-- Create the icon widget
local image_widget = wibox.widget {
  {
      widget = wibox.widget.imagebox,
      image = PATH_TO_ICONS .. 'volume.svg',
      resize = true,
  },
  widget = wibox.container.margin,
}

watch(
  [[bash -c "amixer -D pulse sget Master"]],
  1,
  function(_, stdout)
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    percentage_textbox.text = string.format('%d%%', tonumber(volume))
    collectgarbage('collect')
  end
)

local icon =
  wibox.widget {
  image = icons.volume,
  widget = wibox.widget.imagebox
}

local volume_setting =
  wibox.widget {
      image_widget,
      space,
      percentage_textbox,
      layout = wibox.layout.fixed.horizontal
  }

volume_setting:connect_signal("button::release", function()
  awful.spawn(clic_command)
end)

local volume_container = clickable_container(wibox.container.margin(volume_setting, dpi(8), dpi(8), dpi(8), dpi(8)))

return volume_container
