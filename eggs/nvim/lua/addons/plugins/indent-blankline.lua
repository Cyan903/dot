local pack = require("utils.pack")

pack.install({
    source = { pack.gh "lukas-reineke/indent-blankline.nvim" },
    enabled = true,

    dependencies = {},

    -- Indentation guides
    -- :help ibl
    callback = function()
        require("ibl").setup()
    end
})

