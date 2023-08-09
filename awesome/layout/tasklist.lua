local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local gears = require('gears')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')


local function tasklist_widget(s)

  local tasklist_buttons = awful.util.table.join(
      awful.button({ }, 1, function (c)
          if c == client.focus then
              c.minimized = true
          else
              c:emit_signal("request::activate", "tasklist", {raise = true})
          end
      end),
      awful.button({ }, 2, function ()
          if client.focus then
              client.focus:kill()
          end
      end)
  )
  
  return awful.widget.tasklist {
      screen   = s,
      filter   = awful.widget.tasklist.filter.currenttags,
      buttons  = tasklist_buttons,
      layout   = {
          spacing = 5,
          layout  = wibox.layout.flex.horizontal
      },
      widget_template = {
          {
              {
                  id = 'icon_role',
                  widget = wibox.widget.imagebox,
              },
              margins = 2,
              widget = wibox.container.margin,
          },
          id = 'background_role',
          widget = wibox.container.background,
          create_callback = function(self, c, index, objects) --luacheck: no unused args
              self:get_children_by_id('icon_role')[1].image = c.icon
          end,
          update_callback = function(self, c, index, objects) --luacheck: no unused args
              self:get_children_by_id('icon_role')[1].image = c.icon
          end,
      },
  }
  end

return tasklist_widget