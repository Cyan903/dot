local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })

    -- Floating clients
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = { "copyq" },
            class = {
                "Arandr",
                "Quaver",
                "Quatracker",
                "XIVLauncher.Core",
                "osu!.exe",
                "osu!",
                "steam",
            },

            name = { "Event Tester", "Volume Control" },
            role = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up",
            },
        },

        properties = { floating = true },
    })

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule({
        id = "titlebars",
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true },
    })

    -- Application specific rules
    ruled.client.append_rule({
        rule_any = {
            class = {
                "vesktop",
                "discord",
                "Spotify",
                "Spotify Free",
                "com.github.th_ch.youtube_music",
            },
        },

        properties = { tag = "chat" },
    })

    ruled.client.append_rule({
        rule_any = {
            class = {
                "anki",
                "Anki",
                "chromium",
                "Chromium",
                "obsidian",
            },
        },

        properties = { tag = "study" },
    })

    ruled.client.append_rule({
        rule_any = {
            class = { "steam" },
        },

        properties = { tag = "game" },
    })

    ruled.client.append_rule({
        rule = { class = "ffxiv_dx11.exe" },
        properties = {
            screen = 1,
            maximized_vertical = true,
            maximized_horizontal = true,
        },
    })
end)
