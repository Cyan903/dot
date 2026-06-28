local pack = require("utils.pack")

pack.install({
    source = { pack.gh "nmac427/guess-indent.nvim" },
    enabled = true,

    dependencies = {},

    -- Guess indent
    -- :help GuessIndent
    callback = function()
        require("guess-indent").setup({})
    end
})
