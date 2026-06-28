local pack = require("utils.pack")

pack.install({
    source = { pack.gh "stevearc/oil.nvim" },
    enabled = true,

    dependencies = {},

    -- Buffer file view
    -- :help oil
    callback = function()
        local oil = require("oil")
        local detail = false

        -- Add to which-key menu
        vim.keymap.set("n", "-", oil.open, { desc = "[E]xplore oil" })

        oil.setup({
            view_options = { show_hidden = true },
            keymaps = {
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail

                        if detail
                            then oil.set_columns({ "icon", "permissions", "size", "mtime" })
                            else oil.set_columns({ "icon" })
                        end
                    end
                }
            }
        })
    end
})
