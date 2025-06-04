local awful = require("awful")
local bling = require("lib.bling")

return {
    mod = "Mod4",
    titlebar = false,
    locked_tags = true,

    -- stylua: ignore
    tags = {
        "www", "dev", "study",
        "game", "sandbox", "chat"
    },

    layouts = {
        bling.layout.mstab,

        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.floating,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.max,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw
    },
}
