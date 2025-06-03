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
        vim.keymap.set("n", "-", oil.open, { desc = "[E]xplore oil" })

        oil.setup(opts)
    end,
}
