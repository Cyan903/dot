-- Noctis High Contrast
-- :help N/A
return {
    "iagorrr/noctishc.nvim",

    name = "noctis-high-contrast",
    priority = 1000,

    init = function()
        vim.cmd.colorscheme("noctishc")
    end,
}
