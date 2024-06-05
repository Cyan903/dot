local gears = require("gears")

local BIN_DIR = gears.filesystem.get_dir("config") .. "module/volume/bin/"
local apps = {}

apps.terminal = "alacritty"
apps.editor = os.getenv("EDITOR") or "vi"
apps.editor_cmd = "code"

-- Additional apps for the context menu
apps.context = {
    { "FireFox", "firefox" },
    { "Files", "pcmanfm" },
    { "Clipboard", "copyq menu" }
}

-- Application shortcuts
apps.shortcuts = {
    Audio = {
        {
            alt = {},
            key = "=",
            title = "Audio + 10%",
            cmd = BIN_DIR .. "set-volume +10 true"
        },

        {
            alt = {},
            key = "-",
            title = "Audio -10%",
            cmd = BIN_DIR .. "set-volume -10 true"
        },

        {
            alt = {"Shift"},
            key = "=",
            title = "Audio + 5%",
            cmd = BIN_DIR .. "set-volume +5 true"
        },

        {
            alt = {"Shift"},
            key = "-",
            title = "Audio -5%",
            cmd = BIN_DIR .. "set-volume -5 true"
        }
    },

    Launcher = {
        {
            alt = {},
            key = "\\",
            title = "Firefox",
            cmd = "firefox"
        },

        {
            alt = {},
            key = "BackSpace",
            title = "File Manager",
            cmd = "pcmanfm"
        },

        {
            alt = {},
            key = "f",
            title = "rofi drun",
            cmd = "rofi -disable-history -show drun"
        },

        {
            alt = {},
            key = "r",
            title = "rofi run",
            cmd = "rofi -disable-history -show run"
        },

        {
            alt = {},
            key = "w",
            title = "rofi window",
            cmd = "rofi -disable-history -show window"
        },

        {
            alt = {},
            key = "c",
            title = "copyq menu",
            cmd = "copyq menu"
        },

        {
            alt = {},
            key = "b",
            title = "Show bookmarks",
            cmd = "bookmark show menu"
        },

        {
            alt = {},
            key = "x",
            title = "Kill window",
            cmd = "sxkill"
        }
    }
}

-- Set the terminal for the menubar
require("menubar").utils.terminal = apps.terminal

return apps
