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
require("core.config.options")
require("core.config.keymap")
require("core.config.usercommand")
require("core.config.autocommand")

-- Load plugins
require("util.lazy")({
    plugins = {
        "plugins.firenvim",
        "plugins.ftFT",
        "plugins.indent-blankline",
        "plugins.lorem",
        "plugins.mini",
        "plugins.nvim-autopairs",
        "plugins.slide",
        "plugins.todo-comments",
        "plugins.vim-sleuth",
        "plugins.which-key",
    },

    theme = "vscode",
})
