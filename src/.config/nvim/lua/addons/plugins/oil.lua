-- Buffer file view
-- :help oil
return {
    "stevearc/oil.nvim",

    opts = { view_options = { show_hidden = true } },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },

    config = function(_, opts)
        local oil = require("oil")
        local detail = false

        opts.keymaps = {
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
        }

        -- Add to which-key menu
        require("util.srequire")("which-key", function(key)
            key.add({ { "<leader>e", group = "[E]xplore (oil)" } })
        end)

        vim.keymap.set("n", "<leader>ee", oil.open, { desc = "[E]xplore oil" })
        vim.keymap.set("n", "<leader>ef", oil.open_float, { desc = "[E]xplore [F]loat" })
        vim.keymap.set("n", "<leader>ep", oil.open_preview, { desc = "[E]xplore [P]review" })

        -- Additional bind for normal mode
        vim.keymap.set("n", "-", oil.open, { desc = "[E]xplore oil" })

        oil.setup(opts)
    end,
}
