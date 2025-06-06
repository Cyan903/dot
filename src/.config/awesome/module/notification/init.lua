local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local gears = require("gears")

math.randomseed(os.time())

local ui = require("module.notification.ui")
local ICON_DIR = gears.filesystem.get_dir("config") .. "module/notification/icons/"

-- Main widgets
local notify = wibox.widget.textbox("<span weight='bold'> 0x </span>")
local notify_icon = wibox.widget.imagebox(ICON_DIR .. "empty.svg")
local notify_container = wibox.widget({
    {
        {
            notify_icon,
            margins = 2,
            widget = wibox.container.margin,
        },

        notify,
        layout = wibox.layout.fixed.horizontal,
    },

    shape = ui.rounded,
    widget = wibox.container.background,
})

local notify_pop = awful.popup({
    ontop = true,
    visible = false,
    border_width = 1,
    border_color = beautiful.bg_focus,
    widget = ui.generate_popup(),
    shape = ui.rounded,
})

-- Track updates
local function update()
    local img = "empty.svg"
    local amt = ui.generate_count()

    notify_pop:setup(ui.generate_popup())
    if amt >= 1 then
        img = "full.svg"
    end

    notify.markup = "<span weight='bold'> " .. tostring(amt) .. "x </span>"
    notify_icon.image = ICON_DIR .. img
end

local function uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

    return string.gsub(template, "[xy]", function(c)
        return string.format("%x", (c == "x") and math.random(0, 0xf) or math.random(8, 0xb))
    end)
end

awful.placement.top_right(notify_pop, {
    margins = { top = 30, right = 10 },
    parent = awful.screen.focused(),
})

-- Handle popup
notify_container:connect_signal("button::press", function(_, _1, _2, button)
    if button == 1 then
        notify_pop.visible = not notify_pop.visible
        notify_pop.screen = awful.screen.focused()

        if notify_pop.visible then
            awful.placement.top_right(notify_pop, {
                margins = { top = 30, right = 10 },
                parent = awful.screen.focused(),
            })

            notify_container:set_bg(beautiful.bg_focus)
        else
            notify_container:set_bg("#00000000")
        end
    elseif button == 3 then
        ui.clear()
    end
end)

naughty.connect_signal("added", function(n)
    n._ID = uuid()
    n._DATE = os.time()

    ui.add(n)
    update()
end)

naughty.connect_signal("destroyed", function(n, reason)
    if reason == 2 or reason == 3 then
        ui.remove(n._ID)
    end
end)

awesome.connect_signal("signal::notification_redraw", update)

awesome.connect_signal("signal::notification_close", function()
    notify_pop.visible = false
    notify_container:set_bg("#00000000")
end)

return notify_container
