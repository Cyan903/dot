local awful = require("awful")
local wibox = require("wibox")

-- The titlebar to be used on normal clients
return function(c)
    local buttons = {
        awful.button(nil, 1, function() c:activate({ contexti = "titlebar", action = "mouse_move" }) end),
        awful.button(nil, 3, function() c:activate({ context = "titlebar", action = "mouse_resize" }) end)
    }

    awful.titlebar(c, { position = "top", size = 30 }).widget = wibox.widget({
        {
            {
                awful.titlebar.widget.iconwidget(c),
                layout = wibox.layout.fixed.horizontal()
            },

            layout = wibox.container.margin,
            left = 10,
            right = 10,
            top = 8,
            bottom = 8,
        },

        {
            {
                widget = awful.titlebar.widget.titlewidget(c),
                halign = "center"
            },

            layout = wibox.layout.flex.horizontal,
        },

        -- TODO: Delete this
        -- {
        --     layout = wibox.layout.fixed.horizontal,
        --     awful.titlebar.widget.floatingbutton(c),
        --     awful.titlebar.widget.maximizedbutton(c),
        --     awful.titlebar.widget.stickybutton(c),
        --     awful.titlebar.widget.ontopbutton(c),
        --     awful.titlebar.widget.closebutton(c)
        -- },

        layout = wibox.layout.align.horizontal,
        expand = "none"
    })
end
