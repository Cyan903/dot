-- Grug far search/replace
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
        vim.keymap.set("n", "<leader>r", function()
            grug.toggle_instance({
                instanceName = "far",
                staticTitle = "Find and Replace",
            })
        end, { desc = "[R]eplace open" })

        vim.keymap.set("v", "<leader>r", function()
            grug.with_visual_selection({
                instanceName = "far",
                staticTitle = "Find and Replace",
            })
        end, { desc = "[R]eplace open (word)" })
    end,
}
