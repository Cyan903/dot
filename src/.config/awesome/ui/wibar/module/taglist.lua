local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local user = require("config.user")

local mod = require("binds.mod")
local modkey = mod.modkey

local function create_fade(self, c3, index, objects)
    local sel = 1
    local weight = "normal"
    local fade = {
        "#ffffff",
        "#a5a6a9",
        "#78797f",
        "#4b4d54",
        "#34363e",
        "#30323a",
        "#2b2d36",
        "#272932",
        "#22242d",
    }

    for i in pairs(objects) do
        if objects[i].selected then
            sel = objects[i].index
        end
    end

    if c3.selected then
        weight = "ultrabold"
    end

    self:get_children_by_id("index_role")[1].markup = "<span weight='" .. weight .. "' color='" .. fade[math.abs(index - sel) + 1] .. "' font_desc='FreeMono 8'>" .. objects[index].name .. "</span>"
end

tag.connect_signal("property::selected", function(t)
    if not t.selected or not user.locked_tags then
        return
    end

    for s in screen do
        if s ~= t.screen then
            local other_tag = awful.tag.find_by_name(s, t.name)

            if other_tag then
                other_tag:view_only()
            end
        end
    end

    -- Ensure the master window is always focused (or whatever is found first as a fallback)
    gears.timer.delayed_call(function()
        local mouse_screen = screen[mouse.screen]

        if not mouse_screen then
            return
        end

        local tag = mouse_screen.selected_tag

        if not tag then
            return
        end

        local clients = tag:clients()

        if #clients > 0 then
            local master_client = awful.client.getmaster()

            if master_client then
                client.focus = master_client
                master_client:raise()
            end
        end
    end)
end)

return function(s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button(nil, 1, function(t)
                t:view_only()
            end),

            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),

            awful.button(nil, 3, awful.tag.viewtoggle),

            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),

            awful.button(nil, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),

            awful.button(nil, 5, function(t)
                awful.tag.viewnext(t.screen)
            end),
        },

        widget_template = {
            {
                {
                    {
                        id = "index_role",
                        widget = wibox.widget.textbox,
                    },

                    layout = wibox.layout.fixed.horizontal,
                },

                left = 10,
                right = 10,
                widget = wibox.container.margin,
            },

            id = "background_role",
            widget = wibox.container.background,
            create_callback = create_fade,
            update_callback = create_fade,
        },
    })
end
