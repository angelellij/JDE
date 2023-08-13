local awful = require('awful')
local clickable_container = require('widget.material.clickable-container')

local LayoutIcon = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button( {}, 1, function() awful.layout.inc( 1) end ),
      awful.button( {}, 3, function() awful.layout.inc(-1) end ),
      awful.button( {}, 4, function() awful.layout.inc( 1) end ),
      awful.button( {}, 5, function() awful.layout.inc(-1) end )
    )
  )
  return layoutBox
end

return LayoutIcon