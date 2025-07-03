-- Dracula theme
-- :help dracula
return {
    "Mofiqul/dracula.nvim",

    name = "dracula",
    priority = 1000,

    init = function()
        vim.cmd.colorscheme("dracula")
    end,
}
