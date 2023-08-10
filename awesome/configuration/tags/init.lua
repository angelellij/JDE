local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

awful.layout.layouts = {
  awful.layout.suit.tile
}

local function set_tag(tag, icons)
  if tag.selected then
    tag.icon = icons.sel_tag
  elseif #tag:clients() > 0 then
    tag.icon = icons.ocu_tag  -- Unselected and occupied
  else
    tag.icon = icons.free_tag  -- Unselected and empty
  end
  return tag.icon
end

awful.screen.connect_for_each_screen(
  function(s)
    for i = 1, 4, 1 do

      local tag = awful.tag.add(
        i,
        {
          icon = icons.free_tag,
          icon_only = true,
          layout = awful.layout.suit.tile,
          gap_single_client = false,
          gap = 10,
          screen = s,
          defaultApp = apps.default.rofi,
          selected = i == 1
        }
      )

      tag:connect_signal("property::selected", function()
        set_tag(tag, icons)
      end)

      -- if (s == 1) then 
      --   awful.spawn('discord --silent', {
      --     tag = s.tags[3],
      --     screen = 1
      --   }) 
      -- end
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)

-- Set initial tag icons based on client state
awful.spawn.easy_async_with_shell("sleep 1 && awesome-client 'awesome.emit_signal(\"tag::history::update\")'", function()
  for s in screen do
    for i, tag in pairs(s.tags) do
      set_tag(tag, icons)
    end
  end
end)