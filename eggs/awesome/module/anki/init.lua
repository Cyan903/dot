local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local BIN_DIR = gears.filesystem.get_dir("config") .. "module/anki/bin/"
local ICON_DIR = gears.filesystem.get_dir("config") .. "module/anki/icons/"

-- Helper functions
local rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
end

-- Main widgets
local count = wibox.widget.textbox("<span weight='bold'> .. </span>")
local count_icon = wibox.widget.imagebox(ICON_DIR .. "star.svg")
local count_container = wibox.widget({
    {
        {
            count_icon,
            margins = 2,
            widget = wibox.container.margin,
        },

        count,
        layout = wibox.layout.fixed.horizontal,
    },

    shape = rounded,
    widget = wibox.container.background,
})

-- Update the UI
local update = function()
    count.markup = "<span weight='bold'> .. </span>"

    awful.spawn.easy_async_with_shell(BIN_DIR .. "new", function(stdout)
        local c = tonumber(stdout)

        if c ~= nil then
            count.markup = "<span weight='bold'> " .. tostring(c) .. "x </span>"
            count_container.visible = true
            return
        end

        count_container.visible = false
    end)
end

-- Handle popup
count_container:connect_signal("button::press", function(_, _1, _2, button)
    if button == 3 then
        update()
    end
end)

gears.timer({
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = update,
})

return count_container
