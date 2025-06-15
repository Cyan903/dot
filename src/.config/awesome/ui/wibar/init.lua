local awful = require("awful")
local wibox = require("wibox")

local module = require(... .. ".module")

local taskbar = require("module.taskbar")
local anki = require("module.anki")
local notifications = require("module.notification")
local ping = require("module.ping")
local volume = require("module.volume")
local packages = require("module.packages")
local muted = require("module.muted")
local time = require("module.time")
local system = require("module.system")

return function(s)
    s.mywibox = awful.wibar({
        position = "top",
        height = 30,
        screen = s,
    })

    s.mywibox:setup({
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",

            {
                layout = wibox.layout.fixed.horizontal,

                module.layoutbox(s),
                module.taglist(s),
            },

            module.tasklist(s),

            {
                layout = wibox.layout.fixed.horizontal,

                wibox.container.margin(taskbar, 2, 2),
                wibox.container.margin(anki, 4, 4),
                wibox.container.margin(notifications, 4, 4),
                wibox.container.margin(ping, 4, 4),
                wibox.container.margin(volume, 4, 4),
                wibox.container.margin(packages, 4, 4),
                wibox.container.margin(muted, 2, 4),
                wibox.container.margin(time, 4, 4),
                wibox.container.margin(system, 2, 2),
            },
        },

        widget = wibox.container.margin,
        margins = 5,
    })
end
