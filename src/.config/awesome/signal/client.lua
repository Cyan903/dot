local user = require("config.user")
local beautiful = require("beautiful")

local function toggle_borders(c)
    if c.sticky then
        c.border_color = beautiful.bg_urgent
        return
    end

    -- stylua: ignore
    if c.active
        then c.border_color = beautiful.border_color_active
        else c.border_color = beautiful.border_color_normal
    end
end

-- Add a titlebar if titlebars_enabled is set to true for the client in `config/rules.lua`
client.connect_signal("request::titlebars", function(c)
    if c.requests_no_titlebars or not user.titlebar then
        return
    end

    require("ui.titlebar").normal(c)
end)

-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:activate({ context = "mouse_enter", raise = false })
end)

client.connect_signal("property::sticky", function(c)
    c.ontop = c.sticky and c.floating

    -- stylua: ignore
    if c.sticky
        then c.border_color = beautiful.bg_urgent
        else toggle_borders(c)
    end
end)

client.connect_signal("focus", toggle_borders)
client.connect_signal("unfocus", toggle_borders)
client.connect_signal("manage", toggle_borders)
