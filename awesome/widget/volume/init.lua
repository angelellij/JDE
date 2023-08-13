local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon_button = require('widget.material.icon-button')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')
local gears = require('gears')

local PATH_TO_ICONS = os.getenv('HOME') .. '/.config/awesome/widget/volume/icons/'
local dpi = require('beautiful').xresources.apply_dpi

local slider =
  wibox.widget {
    read_only = false,
    widget = mat_slider,
}

local percentage_textbox = wibox.widget {
  font = 'Roboto 12',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
  
}

local image_widget = wibox.container.margin(
    wibox.widget {
        widget = wibox.widget.imagebox,
        image = PATH_TO_ICONS .. 'volume.svg'
    },
    dpi(8), dpi(8), dpi(8), dpi(8)
)


slider:connect_signal(
  'property::value',
  function()
    spawn('amixer -D pulse sset Master ' .. slider.value .. '%')
    percentage_textbox.text = string.format('%d%%', slider.value)
  end
)

watch(
  [[bash -c "amixer -D pulse sget Master"]],
  1,
  function(_, stdout)
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    slider:set_value(tonumber(volume))
    percentage_textbox.text = string.format('%d%%', tonumber(volume))
    collectgarbage('collect')
  end
)

local icon =
  wibox.widget {
  image = icons.volume,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local volume_setting =
  wibox.widget {
    image_widget,
    percentage_textbox,
    button,
    wibox.container.constraint(slider, 'exact', 50),
    layout = wibox.layout.fixed.horizontal,
    widget = mat_list_item
  }

  
return volume_setting
