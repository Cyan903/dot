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
            cmd = "pactl -- set-sink-volume 0 +10%"
        },

        {
            alt = {},
            key = "-",
            title = "Audio -10%",
            cmd = "pactl -- set-sink-volume 0 -10%"
        },

        {
            alt = {"Shift"},
            key = "=",
            title = "Audio + 5%",
            cmd = "pactl -- set-sink-volume 0 +5%"
        },

        {
            alt = {"Shift"},
            key = "-",
            title = "Audio -5%",
            cmd = "pactl -- set-sink-volume 0 -5%"
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
