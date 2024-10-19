-- Slide dynamically through paragraphs
-- :help N/A
return {
    "jake-stewart/slide.nvim",

    config = function()
        local slide = require("slide")

        vim.keymap.set({ "n", "v" }, "<leader>k", slide.up, { desc = "Slide up" })
        vim.keymap.set({ "n", "v" }, "<leader>j", slide.down, { desc = "Slide down" })
    end,
}
