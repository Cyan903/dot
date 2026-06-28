local pack = require("utils.pack")

pack.install({
    source = { pack.gh "folke/flash.nvim" },
    enabled = true,

    dependencies = {},

    -- Improved movement
    -- :help flash
    callback = function()
        local flash = require("flash")

        flash.setup({
            modes = {
                char = { enabled = false },
            },
        })

        vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
        vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
        vim.keymap.set({ "c" }, "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })
    end
})
