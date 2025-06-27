vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = true

-- Load config
require("core.config.options")
require("core.config.keymap")
require("core.config.usercommand")
require("core.config.autocommand")

require("util.header")()

-- Load plugins
require("util.lazy")({
    plugins = { "plugins" },
    theme = "dracula",
})
