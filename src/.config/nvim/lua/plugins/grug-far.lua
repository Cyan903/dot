-- Grug Far Search/Replace
-- :help grug-far
return {
    "MagicDuck/grug-far.nvim",

    config = function()
        local grug = require("grug-far")

        grug.setup({
            engines = {
                ripgrep = {
                    path = "rg",
                    extraArgs = "",
                    showReplaceDiff = true,
                    placeholders = { enabled = false },
                },
            },
        })

        -- Set keybinds
        vim.keymap.set("n", "<leader>rr", function()
            grug.toggle_instance({
                instanceName = "far",
                staticTitle = "Find and Replace",
            })
        end, { desc = "[R]eplace open" })

        -- Add to which-key menu
        require("util.safe_require")("which-key", function(key)
            key.add({
                { "<leader>r", group = "[R]eplace (grug-far)" },
            })
        end)
    end,
}
