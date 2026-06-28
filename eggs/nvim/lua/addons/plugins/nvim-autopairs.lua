local pack = require("utils.pack")

pack.install({
    source = { pack.gh "windwp/nvim-autopairs" },
    enabled = true,

    dependencies = {},

    -- Autopairs
    -- :help nvim-autopairs
    callback = function()
        require("nvim-autopairs").setup({})
    end,
})
