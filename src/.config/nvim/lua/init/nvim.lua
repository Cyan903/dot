vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = true

-- Load config
require("config.opt")
require("config.keymap")
require("config.usercommand")
require("config.autocommand")

require("util.load_header")()

-- Load plugins
require("util.lazy")({
    plugins = { "plugins" },
    theme = "dracula",
})
