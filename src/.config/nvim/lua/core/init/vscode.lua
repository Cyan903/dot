vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = false

-- Load config
require("core.config.options")
require("core.config.keymap")
require("core.config.usercommand")
require("core.config.autocommand")

-- Load plugins
require("util.lazy")({
    plugins = {
        "plugins.flash",
        "plugins.ftFT",
        "plugins.mini",
        "plugins.nvim-autopairs",
        "plugins.slide",
        "plugins.vim-sleuth",
    },
})
