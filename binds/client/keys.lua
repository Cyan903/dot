local awful = require("awful")

local mod = require("binds.mod")
local modkey = mod.modkey

-- Client keybindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Client state management
        awful.key({ modkey, mod.shift }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,

            { description = "Toggle fullscreen", group = "Client" }
        ),

        awful.key({ modkey, mod.shift }, "c",
            function(c) c:kill() end,
            { description = "Close", group = "Client" }
        ),

        awful.key({ modkey, mod.ctrl }, "space",
            awful.client.floating.toggle,
            { description = "Toggle Floating", group = "Client" }
        ),

        awful.key({ modkey }, "n",
            function(c) c.minimized = true end,
            { description = "Minimize", group = "Client" }
        ),

        awful.key({ modkey }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            
            { description = "(un)maximize", group = "Client" }
        ),

        -- Client position in tiling management
        awful.key({ modkey, mod.ctrl  }, "Return",
            function(c) c:swap(awful.client.getmaster()) end,
            { description = "Move to master", group = "Client" }
        ),

        awful.key({ modkey }, "o",
            function(c) c:move_to_screen() end,
            { description = "Move to screen", group = "Client" }
        ),

        awful.key({ modkey }, "t",
            function(c) c.ontop = not c.ontop end,
            { description = "Toggle keep on top", group = "Client" }
        )
    })
end)
