-- Tree file view :help nvim-tree
return {
    "nvim-tree/nvim-tree.lua",

    opts = {
        sort = { sorter = "case_sensitive" },
        view = { width = 30, side = "right" },
        renderer = { group_empty = false },
        filters = {
            dotfiles = false,
            git_ignored = false,
        },
    },

    config = function(_, opts)
        local tree = require("nvim-tree")

        vim.keymap.set("n", "<leader>ex", ":NvimTreeToggle<CR>", { desc = "E[x]plore nvim-tree" })
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "[F]ocus file" })

        tree.setup(opts)
    end,
}
