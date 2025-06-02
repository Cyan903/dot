local config = require("config.apps")
local bindings = require("utils.bindings")

-- Read the config
bindings.binds.set_apps(config)

-- Set the keybinds for active shortcuts
awesome.connect_signal("startup", bindings.signals.startup)
client.connect_signal("focus", bindings.signals.focus)
