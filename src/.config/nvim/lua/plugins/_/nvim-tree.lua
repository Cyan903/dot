-- Tree file view
-- :help nvim-tree
return {
    "nvim-tree/nvim-tree.lua",

    enabled = false,

    opts = {
        sort = { sorter = "case_sensitive" },
        view = { width = 40, side = "right" },
        renderer = { group_empty = false },
        filters = {
            dotfiles = false,
            git_ignored = false,
        },
    },

    config = function(_, opts)
        local tree = require("nvim-tree")

        -- Add to which-key menu
        require("util.srequire")("which-key", function(key)
            key.add({ { "<leader>e", group = "[E]xplore (nvim-tree)" } })
        end)

        vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplore nvim-tree" })
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "[F]ocus file" })

        tree.setup(opts)
    end,
}
