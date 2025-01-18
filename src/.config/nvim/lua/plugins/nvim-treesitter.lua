-- Treesitter
-- :help nvim-treesitter
return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",
    opts = {
        ensure_installed = vim.tbl_deep_extend("force", {
            "lua",
            "luadoc",
            "vim",
            "vimdoc",
        }, require("cfg").treesitter.ensure_installed),

        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = require("cfg").treesitter.vim_regex,
        },

        indent = {
            enable = true,
            disable = require("cfg").treesitter.indent_disable,
        },
    },

    config = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup(opts)
    end,
}
