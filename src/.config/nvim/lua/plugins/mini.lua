-- mini.nvim - Various small QOL improvements
-- :help mini
return {
    {
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

        {
            "echasnovski/mini.surround",

            version = false,
            config = function()
                -- Add/delete/replace surroundings (brackets, quotes, etc.)
                -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
                -- - sd'   - [S]urround [D]elete [']quotes
                -- - sr)'  - [S]urround [R]eplace [)] [']
                require("mini.surround").setup()
            end,
        },

        {
            "echasnovski/mini.statusline",

            version = false,
            config = function()
                -- Simple status line
                local statusline = require("mini.statusline")
                statusline.setup({ use_icons = vim.g.have_nerd_font })

                ---@diagnostic disable-next-line: duplicate-set-field
                statusline.section_location = function()
                    return "%2l:%-2v"
                end
            end,
        },
    },
}
