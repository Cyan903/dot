local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local notify_list = { layout = wibox.layout.fixed.vertical }

math.randomseed(os.time())

-- Helper functions
local rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
end

local function uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

    return string.gsub(template, "[xy]", function (c)
        return string.format(
            "%x",
            (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        )
    end)
end

-- Main widgets
local notif_header = wibox.widget.textbox("...")
local clear_button = wibox.widget {
    {
        {
            markup = "<span weight='bold'>x</span>",
            align = "center",
            forced_width = 20,
            widget = wibox.widget.textbox
        },

        forced_height = 20,
        layout = wibox.layout.fixed.horizontal
    },

    shape = rounded,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
}

-- Main functions
local function remove(id)
    local notify_new = { layout = wibox.layout.fixed.vertical }

    for key in pairs(notify_list) do
        if key ~= "layout" and notify_list[key]._ID ~= id then
            notify_new[#notify_new+1] = notify_list[key]
        end
    end

    notify_list = notify_new
    awesome.emit_signal("signal::notification_redraw")
end

local function add(n)
    local title = n.title
    local message = n.message

    local id = uuid()
    local close_button = wibox.widget {
        {
            {
                markup = "<span weight='bold'>Close</span>",
                align = "center",
                forced_width = 200,
                widget = wibox.widget.textbox
            },

            forced_height = 25,
            layout = wibox.layout.fixed.horizontal
        },

        bg = beautiful.bg_focus .. "44",
        widget = wibox.container.background
    }

    if title == "" then title = "Awesome - No Title"; end
    if message == "" then message = "..."; end

    -- Animations
    close_button:connect_signal("mouse::enter", function() close_button.bg = beautiful.bg_focus end)
    close_button:connect_signal("mouse::leave", function() close_button.bg = beautiful.bg_focus .. "44" end)
    close_button:connect_signal("button::press", function(_, _1, _2, button)
        if button == 1 then remove(id) end
    end)

    notify_list[#notify_list+1] = {
        _ID = id,

        {
            {
                -- Titlebar
                {
                    {
                        {
                            wrap = "word_char",
                            text = title,
                            color = beautiful.border_color_active, -- TODO: Fix
                            widget = wibox.widget.textbox
                        },

                        widget = wibox.container.margin,
                        margins = 8
                    },

                    bg = beautiful.titlebar_bg_normal .. "44",
                    widget = wibox.container.background
                },

                -- Message box
                {
                    {
                        {
                            {
                                wibox.widget.imagebox(n.icon),

                                forced_height = 48,
                                halign = "center",
                                valign = "center",
                                widget = wibox.container.place
                            },

                            {
                                wibox.widget.textbox(n.message),

                                left = 5,
                                right = 5,
                                widget = wibox.container.margin
                            },

                            widget = wibox.layout.fixed.horizontal
                        },

                        margins = 4,
                        widget = wibox.container.margin
                    },

                    bg = beautiful.titlebar_bg_normal,
                    widget = wibox.container.background
                },

                close_button,
                widget = wibox.layout.fixed.vertical
            },

            strategy = "min",
            width = 240,
            forced_width = 240,
            widget = wibox.container.constraint
        },

        top = 10,
        bottom = 10,
        widget = wibox.container.margin
    }
end

local function clear()
    notify_list = { layout = wibox.layout.fixed.vertical }
    awesome.emit_signal("signal::notification_redraw")
end

local function generate_popup()
    local notify_result = notify_list

    -- TODO: Add "...and" more if notification count is too high
    notif_header = wibox.widget.textbox("<span weight='ultrabold'>Notifications</span> <span>(" .. tostring(#notify_list) .. ")</span>")

    if #notify_list == 0 then
        notify_result = {
            {
                {
                    markup = "<span weight='ultrabold' size='x-large'>You don't have any notifications!</span>",
                    align = "center",
                    widget = wibox.widget.textbox
                },

                layout = wibox.container.background
            },

            strategy = "min",
            height = 350,
            layout = wibox.container.constraint
        }
    end

    return {
        {
            {
                {

                    {
                        notif_header,
                        wibox.container.margin(clear_button, 100, 0, 0, 0),

                        layout = wibox.layout.fixed.horizontal
                    },

                    notify_result,

                    widget = wibox.layout.fixed.vertical,
                },

                margins = 10,
                widget = wibox.container.margin
            },

            strategy = "max",
            width = 250,
            layout = wibox.container.constraint
        },

        strategy = "min",
        height = 500,
        layout = wibox.container.constraint
    }
end

local function generate_count()
    return #notify_list
end

-- Animations
clear_button:connect_signal("mouse::enter", function() clear_button.bg = beautiful.bg_focus end)
clear_button:connect_signal("mouse::leave", function() clear_button.bg = beautiful.bg_normal end)
clear_button:connect_signal("button::press", function(_, _1, _2, button) if button == 1 then clear() end end)

return {
    add = add,
    remove = remove,
    rounded = rounded,
    generate_count = generate_count,
    generate_popup = generate_popup
}
