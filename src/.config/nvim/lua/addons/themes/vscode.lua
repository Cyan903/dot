-- Visual Studio Code theme
-- :help N/A
return {
    "Mofiqul/vscode.nvim",

    name = "vscode",
    priority = 1000,

    init = function()
        vim.cmd.colorscheme("vscode")
    end,

    opts = {
        group_overrides = {
            CursorLineNr = { fg = "#CE9178", bg = "#1F1F1F", bold = true },
            NvimTreeNormal = { fg = "#D4D4D4", bg = "#181818" },
        },
    },
}
