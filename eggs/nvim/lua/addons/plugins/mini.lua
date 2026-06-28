local pack = require("utils.pack")

-- mini.nvim - Various small QOL improvements
-- :help mini
pack.install({
    source = { pack.gh "echasnovski/mini.ai" },
    enabled = true,

    dependencies = {},

    -- Better Around/Inside textobjects
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- :help mini.ai
    callback = function()
        require("mini.ai").setup({ n_lines = 500 })
    end
})

pack.install({
    source = { pack.gh "echasnovski/mini.splitjoin" },
    enabled = true,

    dependencies = {},

    -- Split into multiple lines (opposite of J)
    -- :help mini.ai
    callback = function()
        require("mini.splitjoin").setup()
    end
})
