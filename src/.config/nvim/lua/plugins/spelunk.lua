-- Better bookmarks
-- :help spelunk
return {
    "EvWilson/spelunk.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },

    opts = {
        base_mappings = {
            toggle = "<leader>hh",
            add = "<leader>ha",
            next_bookmark = "<C-M-j>",
            prev_bookmark = "<C-M-k>",
            search_bookmarks = "<leader>hf",
            search_current_bookmarks = "<leader>hc",
            search_stacks = "<leader>hs",
        },

        window_mappings = {
            cursor_down = "j",
            cursor_up = "k",
            bookmark_down = "<C-j>",
            bookmark_up = "<C-k>",
            goto_bookmark = "<CR>",
            goto_bookmark_hsplit = "x",
            goto_bookmark_vsplit = "v",
            delete_bookmark = "d",
            next_stack = "<Tab>",
            previous_stack = "<S-Tab>",
            new_stack = "n",
            delete_stack = "D",
            edit_stack = "E",
            close = "q",
            help = "h",
        },

        enable_persist = true,
        orientation = "vertical",
        enable_status_col_display = true,
    },

    config = function(_, opts)
        local spelunk = require("spelunk")

        -- Add to which-key menu
        require("util.srequire")("which-key", function(key)
            key.add({ { "<leader>h", group = "[H]otspot Marks (spelunk)" } })
        end)

        spelunk.setup(opts)
    end,
}
