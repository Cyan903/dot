local pack = require("utils.pack")

pack.install({
    source = { pack.gh "gukz/ftFT.nvim" },
    enabled = true,

    dependencies = {},

    -- Highlight unique f/t & F/T
    -- :help ftFT
    callback = function()
        require("ftFT").setup({
            keys = { "f", "t", "F", "T" },
            modes = { "n", "v" },
            hl_group = "Search",
            sight_hl_group = "",
        })
    end
})
