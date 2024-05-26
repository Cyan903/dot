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

-- Set the terminal for the menubar
require("menubar").utils.terminal = apps.terminal

return apps
