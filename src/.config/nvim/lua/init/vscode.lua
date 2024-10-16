vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = false

-- Load config
require("config.opt")
require("config.keymap")
require("config.usercommand")
require("config.autocommand")

-- Load plugins
require("util.lazy")({
    -- TODO: this...
    require("plugins.ftFT"),
    require("plugins.flash"),
})
