-- mini.nvim - Various small QOL improvements
-- :help mini
return {
    {
        -- :help mini.ai
        {
            "echasnovski/mini.ai",

            version = false,
            config = function()
                -- Better Around/Inside textobjects
                -- Examples:
                --  - va)  - [V]isually select [A]round [)]paren
                --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
                --  - ci'  - [C]hange [I]nside [']quote
                require("mini.ai").setup({ n_lines = 500 })
            end,
        },

        -- :help mini.splitjoin
        {
            "echasnovski/mini.splitjoin",

            version = false,
            config = function()
                -- Split into multiple lines (opposite of J)
                -- - gS - Split line
                require("mini.splitjoin").setup()
            end,
        },
    },
}
