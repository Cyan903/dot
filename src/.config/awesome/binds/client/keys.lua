local awful = require("awful")
local gears = require("gears")

local floating = require("utils.workspaces").floating
local monitor = require("utils.workspaces").monitor

local mod = require("binds.mod")
local modkey = mod.modkey

floating.set_amt(5)

-- Client keybindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Client state management
        awful.key({ modkey, mod.shift }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "Toggle fullscreen", group = "Client" }),

        awful.key({ modkey, mod.shift }, "c", function(c)
            c:kill()
        end, { description = "Close", group = "Client" }),

        awful.key({ modkey, mod.ctrl }, "space", awful.client.floating.toggle, { description = "Toggle Floating", group = "Client" }),

        awful.key({ modkey }, "n", function(c)
            c.minimized = true
        end, { description = "Minimize", group = "Client" }),

        awful.key({ modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "Client" }),

        -- Client position in tiling management
        awful.key({ modkey, mod.ctrl }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "Move to master", group = "Client" }),

        -- Client screen management
        awful.key({ modkey, mod.shift, mod.alt }, "Right", monitor.move_screens("right"), { description = "Swap window right", group = "Client" }),
        awful.key({ modkey, mod.shift, mod.alt }, "Left", monitor.move_screens("left"), { description = "Swap window left", group = "Client" }),
        awful.key({ modkey, mod.shift, mod.alt }, "Up", monitor.move_screens("up"), { description = "Swap window up", group = "Client" }),
        awful.key({ modkey, mod.shift, mod.alt }, "Down", monitor.move_screens("down"), { description = "Swap window down", group = "Client" }),

        -- Client position for floating management
        awful.key({ modkey, mod.shift }, "Up", function(c)
            floating.move_floating(c, 0, -1)
        end, { description = "Move floating client up", group = "Client" }),

        awful.key({ modkey, mod.shift }, "Down", function(c)
            floating.move_floating(c, 0, 1)
        end, { description = "Move floating client down", group = "Client" }),

        awful.key({ modkey, mod.shift }, "Left", function(c)
            floating.move_floating(c, -1, 0)
        end, { description = "Move floating client left", group = "Client" }),

        awful.key({ modkey, mod.shift }, "Right", function(c)
            floating.move_floating(c, 1, 0)
        end, { description = "Move floating client right", group = "Client" }),

        awful.key({ modkey, mod.ctrl, mod.shift }, "Up", function(c)
            floating.resize_floating(c, 0, -1)
        end, { description = "Decrease floating client height", group = "Client" }),

        awful.key({ modkey, mod.ctrl, mod.shift }, "Down", function(c)
            floating.resize_floating(c, 0, 1)
        end, { description = "Incraese floating client height", group = "Client" }),

        awful.key({ modkey, mod.ctrl, mod.shift }, "Left", function(c)
            floating.resize_floating(c, -1, 0)
        end, { description = "Decrease floating client width", group = "Client" }),

        awful.key({ modkey, mod.ctrl, mod.shift }, "Right", function(c)
            floating.resize_floating(c, 1, 0)
        end, { description = "Increase floating client width", group = "Client" }),
    })
end)
