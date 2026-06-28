local pack = require("utils.pack")

pack.install({
    source = { pack.gh "nvim-tree/nvim-tree.lua" },
    enabled = true,

    dependencies = {
        {
            source = { pack.gh "nvim-tree/nvim-web-devicons" },
            enabled = vim.g.have_nerd_font,
            callback = function() require("nvim-web-devicons").setup({}) end
        }
    },

    -- Tree file view
    -- :help nvim-tree
    callback = function()
        require("nvim-tree").setup({
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
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplore nvim-tree" })
    end
})
