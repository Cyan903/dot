local pack = require("utils.pack")

pack.install({
    source = { pack.gh "folke/which-key.nvim" },
    enabled = true,

    dependencies = {},

    -- Show pending keybinds
    -- :help which-key
    callback = function()
        require("which-key").setup({})
    end
})
