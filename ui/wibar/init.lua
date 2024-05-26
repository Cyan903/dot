local awful = require("awful")
local wibox = require("wibox")

local module = require(... .. ".module")

return function(s)
    s.mywibox = awful.wibar({
        position = "top",
        height = 30,
        screen = s
    })
    
    s.mywibox:setup {
        {            
            layout = wibox.layout.align.horizontal,
            expand = "none",

            {
                layout = wibox.layout.fixed.horizontal,
                module.layoutbox(s),
                module.taglist(s)
            },

            module.tasklist(s),

            {
                layout = wibox.layout.fixed.horizontal,
                awful.widget.keyboardlayout(),
                wibox.widget.systray(),
                wibox.widget.textclock()
            }
        },

        widget = wibox.container.margin,
        margins = 5
    }
end
