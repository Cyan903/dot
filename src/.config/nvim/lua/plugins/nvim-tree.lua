-- Tree file view
-- :help nvim-tree
return {
    "nvim-tree/nvim-tree.lua",

    opts = {
        sort = { sorter = "case_sensitive" },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        view = { width = 25 },
        renderer = { group_empty = false },
        filters = { dotfiles = true },
    },

    config = function(_, opts)
        local tree = require "nvim-tree"

        vim.keymap.set("n", "<leader>ex", ":NvimTreeToggle<CR>", { desc = "E[x]plore nvim-tree" })
        vim.keymap.set("n", "<leader>ee", ":NvimTreeFocus<CR>", { desc = "Focus nvim-tr[e]e" })
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "[F]ocus file" })

        tree.setup(opts)
    end,
}
