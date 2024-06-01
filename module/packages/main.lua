local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local ICON_DIR = gears.filesystem.get_dir("config") .. "module/packages/icons/"
local BIN_DIR = gears.filesystem.get_dir("config") .. "module/packages/bin/"

-- Main widgets
local count = wibox.widget.textbox("<span weight='bold'> .. </span>")
local count_container = wibox.widget {
    {
        {
            image = ICON_DIR .. "package.svg",
            widget = wibox.widget.imagebox
        },

        margins = 2,
        widget = wibox.container.margin
    },

    count,
    layout = wibox.layout.fixed.horizontal
}

-- Track updates 
local update = function()
    count.markup = "<span weight='bold'> .. </span>"

    awful.spawn.easy_async_with_shell(BIN_DIR .. "check", function(stdout)
        local u = tonumber(stdout)

        if u ~= nil then
            count.markup = "<span weight='bold'> ".. tostring(u) .."x </span>"
        end
    end)
end

awesome.connect_signal("signal::packages_upgrade", update)
count_container:connect_signal("button::press", update)

gears.timer {
    timeout = 120,
    call_now = true,
    autostart = true,
    callback = update
}

return count_container
