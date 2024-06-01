local awful = require("awful")
local wibox = require("wibox")

local module = require(... .. ".module")

local taskbar = require("module.taskbar.main")
local time = require("module.time.main")

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
                taskbar,
                awful.widget.keyboardlayout(),
                time,
            }
        },

        widget = wibox.container.margin,
        margins = 5
    }
end
