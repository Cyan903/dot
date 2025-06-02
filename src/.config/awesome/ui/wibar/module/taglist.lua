local awful = require("awful")
local wibox = require("wibox")

local user = require("config.user")

local fade = require("utils.fade")
local locked = require("utils.workspaces").locked

local mod = require("binds.mod")
local modkey = mod.modkey

tag.connect_signal("property::selected", function(t)
    if user.locked_tags then
        locked(t)
    end
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
            create_callback = fade,
            update_callback = fade,
        },
    })
end
