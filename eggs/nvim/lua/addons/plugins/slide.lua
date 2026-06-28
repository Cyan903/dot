local pack = require("utils.pack")

pack.install({
    source = { pack.gh "jake-stewart/slide.nvim" },
    enabled = true,

    dependencies = {},

    -- Slide dynamically through paragraphs
    -- :help N/A
    callback = function()
        local slide = require("slide")

        vim.keymap.set({ "n", "v" }, "<leader>k", slide.up, { desc = "Slide up" })
        vim.keymap.set({ "n", "v" }, "<leader>j", slide.down, { desc = "Slide down" })
    end
})
