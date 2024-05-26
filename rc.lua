-- awesome_mode: api-level=4:screen=on
pcall(require, "luarocks.loader")

--- Error handling.
local naughty = require("naughty")
local awful = require("awful")
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config).
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message
    })
end)

-- Allow Awesome to automatically focus a client & startup script
require("awful.autofocus")
require("awful.spawn").with_shell(require("gears.filesystem").get_dir("config") .. "bin/autostart")

require("theme")
require("signal")

-- Set all keybinds
require("binds")

-- Load all client rules.
require("config.rules")

-- TODO: Deal with all the comments
