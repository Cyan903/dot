-- Tree file view
-- :help nvim-tree
return {
    "nvim-tree/nvim-tree.lua",

    opts = {
        sort = { sorter = "case_sensitive" },
        renderer = { group_empty = false },
        view = {
            width = 40,
            side = "right",
            preserve_window_proportions = true,
        },

        filters = {
            dotfiles = false,
            git_ignored = false,
        },

        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
    },

    config = function(_, opts)
        local tree = require("nvim-tree")

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplore nvim-tree" })

        tree.setup(opts)
    end,
}
