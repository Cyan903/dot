local awful = require("awful")
local user = require("config.user")
local beautiful = require("beautiful")

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

local function toggle_bar(c, show)
    if show and user.titlebar then
        awful.titlebar.show(c, "top")
        return
    end

    awful.titlebar.hide(c, "top")
end

-- Enable border/titlebar toggle for floating windows
-- TODO: Simplify
local function toggle_borders(c)
    if c.maximized then
        c.border_color = beautiful.border_color_normal
        return
    end

    if c.floating then
        c.border_color = beautiful.border_color_normal
        toggle_bar(c, true)
        return
    end

    c.border_color = beautiful.border_color_normal
    toggle_bar(c, false)

    if c.active then
        c.border_color = beautiful.border_color_active
    end
end

client.connect_signal("focus", toggle_borders)
client.connect_signal("unfocus", toggle_borders)
client.connect_signal("manage", toggle_borders)
