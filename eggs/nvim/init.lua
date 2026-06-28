vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Used to display icons
vim.g.have_nerd_font = true

-- Use to enable LSP
vim.g.lsp_enabled = true

-- Load core config
require("core")

-- Load external addons
require("addons")({
    plugins = {
        "which-key",
        "lsp",

        "fcitx5",
        "flash",
        "ftFT",
        "gitsigns",
        "grug-far",
        "guess-indent",
        "indent-blankline",
        "mini",
        "nvim-autopairs",
        "nvim-tree",
        "oil",
        "slide",
        "spelunk",
        "telescope",
        "tmux-navigator",
        "todo-comments",
        "toggleterm",
    },

    theme = "noctis-high-contrast",
})