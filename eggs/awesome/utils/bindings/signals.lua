local binds = require("utils.bindings.binds")

local function startup()
    binds.init_shortcuts()
    binds.init_keybinds()
end

local function focus(e)
    binds.remove_apps()
    binds.set_app(e)
end

return {
    startup = startup,
    focus = focus,
}
