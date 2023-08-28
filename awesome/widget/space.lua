local wibox = require('wibox')

return wibox.widget {
	id = "space",
	widget = wibox.widget.textbox,
	text = "  ",
	align = "center",
	font = 'Roboto 12'
  }