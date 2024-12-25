local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local BIN_DIR = gears.filesystem.get_dir("config") .. "module/muted/bin/"

-- Main widgets
local muted = wibox.widget.textbox("<span weight='bold'> - </span>")
local muted_container = wibox.widget({
    {
        muted,
        layout = wibox.layout.fixed.horizontal,
    },

    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,

    widget = wibox.container.background,
})

local function get_muted()
    awful.spawn.easy_async_with_shell(BIN_DIR .. "status", function(stdout)
        local m = tonumber(stdout)

        if m ~= nil then
            awesome.emit_signal("signal::update_muted", m)
        end
    end)
end

-- Update the UI
local update = function(m)
    if m == 0 then
        muted.markup = "<span weight='bold'> - </span>"
        return
    end

    muted.markup = "<span weight='bold' color='red'> - </span>"
end

gears.timer({
    timeout = 120,
    call_now = true,
    autostart = true,
    callback = get_muted,
})

awesome.connect_signal("signal::update_muted", update)
awesome.connect_signal("signal::get_muted", get_muted)

return muted_container
