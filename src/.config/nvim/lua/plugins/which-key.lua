-- Show pending keybinds
-- :help which-key
return {
    "folke/which-key.nvim",

    event = "VimEnter",
    config = function()
        require("which-key").setup()
        require("which-key").add({
            -- TODO: Remove this
            { "<leader>t", group = "[T]erminal" },
        })
    end,
}
