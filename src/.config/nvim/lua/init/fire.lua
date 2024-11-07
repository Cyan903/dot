vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = false

-- Firenvim
vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never",
        },
    },
}

-- Load config
require("config.opt")
require("config.keymap")
require("config.usercommand")
require("config.autocommand")

-- Load plugins
require("util.lazy")({
    plugins = {
        "plugins.firenvim",

        "plugins.flash",
        "plugins.ftFT",
        "plugins.indent-blankline",
        "plugins.mini",
        "plugins.nvim-autopairs",
        "plugins.slide",
        "plugins.todo-comments",
        "plugins.vim-sleuth",
        "plugins.which-key",
    },

    theme = "dracula",
})
