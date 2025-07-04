local gears = require("gears")

local BIN_DIR = gears.filesystem.get_dir("config") .. "bin/"
local apps = {}

apps.terminal = "alacritty"
apps.editor = os.getenv("EDITOR") or "vi"
apps.editor_cmd = apps.terminal .. " -e " .. apps.editor

-- Additional apps for the context menu
apps.context = {
    { "FireFox", "firefox" },
    { "Files", "pcmanfm" },
    { "Clipboard", "copyq menu" },
}

-- Application shortcuts
apps.shortcuts = {
    {
        group = "Audio",
        binds = {
            {
                alt = {},
                key = "=",
                title = "Audio + 10%",
                cmd = BIN_DIR .. "set-volume +10 true",
            },

            {
                alt = {},
                key = "-",
                title = "Audio -10%",
                cmd = BIN_DIR .. "set-volume -10 true",
            },

            {
                alt = { "Shift" },
                key = "=",
                title = "Audio + 5%",
                cmd = BIN_DIR .. "set-volume +5 true",
            },

            {
                alt = { "Shift" },
                key = "-",
                title = "Audio -5%",
                cmd = BIN_DIR .. "set-volume -5 true",
            },

            {
                alt = { "Shift" },
                key = "m",
                title = "Microphone mute toggle",
                cmd = BIN_DIR .. "mute-toggle",
            },
        },
    },

    {
        group = "Music",
        binds = {
            {
                alt = { "Ctrl" },
                key = "p",
                title = "Toggle music",
                cmd = "yt-music toggle",
            },

            {
                alt = { "Ctrl" },
                key = "[",
                title = "Previous song",
                cmd = "yt-music prev",
            },

            {
                alt = { "Ctrl" },
                key = "]",
                title = "Next song",
                cmd = "yt-music next",
            },

            {
                alt = { "Ctrl" },
                key = "-",
                title = "Volume -10",
                cmd = "yt-music vol -10",
            },

            {
                alt = { "Ctrl" },
                key = "=",
                title = "Volume +10",
                cmd = "yt-music vol 10",
            },
        },
    },

    {
        group = "Launcher",
        binds = {
            {
                alt = {},
                key = "\\",
                title = "Firefox",
                cmd = "firefox",
            },

            {
                alt = { "Shift" },
                key = "\\",
                title = "Chromium (Incognito)",
                cmd = "chromium --incognito",
            },

            {
                alt = {},
                key = "BackSpace",
                title = "File Manager",
                cmd = "pcmanfm",
            },

            {
                alt = {},
                key = "f",
                title = "rofi drun",
                cmd = "rofi -disable-history -show drun",
            },

            {
                alt = {},
                key = "r",
                title = "rofi run",
                cmd = "rofi -disable-history -show run",
            },

            {
                alt = {},
                key = "w",
                title = "rofi window",
                cmd = "rofi -disable-history -show window",
            },

            {
                alt = {},
                key = "c",
                title = "copyq menu",
                cmd = "copyq menu",
            },

            {
                alt = {},
                key = "b",
                title = "Show bookmarks",
                cmd = "bookmark show menu",
            },

            {
                alt = {},
                key = "x",
                title = "Kill window",
                cmd = "sxkill",
            },

            {
                alt = { "Ctrl" },
                key = "s",
                title = "Screenshot of selection",
                cmd = "screenshot",
            },

            {
                alt = { "Shift" },
                key = "s",
                title = "Screenshot with ocr-shot",
                cmd = "ocr-shot",
            },

            {
                alt = {},
                key = "s",
                title = "Screenshot of monitor",
                cmd = "screenshot --monitor",
            },

            {
                alt = { "Shift" },
                key = "d",
                title = "Open dynamic wallpaper",
                cmd = "dynamic-wallpaper",
            },
        },
    },
}

apps.active = {
    {
        group = "Obsidian",
        class = { "obsidian" },
        binds = {
            {
                alt = {},
                key = "F1",
                title = "Git sync",
                cmd = "obsidian-git",
            },
        },
    },

    {
        group = "osu!",
        class = { "osu!.exe", "osu!", "steam_app_727" },
        binds = {
            {
                alt = {},
                key = "F1",
                title = "Drop ~/Downloads/*.osz",
                cmd = 'bash -c "blobdrop ~/Downloads/*.osz"',
            },

            {
                alt = {},
                key = "F2",
                title = "Start/stop gosumemory",
                cmd = "gosumem",
            },
        },
    },

    {
        group = "Quaver",
        class = { "Quaver" },
        binds = {
            {
                alt = {},
                key = "F1",
                title = "Drop ~/Downloads/*.osz",
                cmd = 'bash -c "blobdrop ~/Downloads/*.osz"',
            },

            {
                alt = {},
                key = "F2",
                title = "Drop ~/Downloads/*.qp",
                cmd = 'bash -c "blobdrop ~/Downloads/*.qp"',
            },

            {
                alt = {},
                key = "F3",
                title = "Launch Quatracker",
                cmd = "quatracker",
            },
        },
    },

    {
        group = "Discord",
        class = { "discord", "Discord", "vesktop", "Vesktop" },
        binds = {
            {
                alt = {},
                key = "F1",
                title = "Toggle microphone mute",
                cmd = BIN_DIR .. "mute-toggle",
            },
        },
    },
}

-- Set the terminal for the menubar
require("menubar").utils.terminal = apps.terminal

return apps
