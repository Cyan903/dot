-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Enable folds {{{
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("fold-filetype", { clear = true }),
    pattern = { "vim", "lua" },
    callback = function()
        vim.opt_local.foldmethod = "marker"
    end,
})
-- }}}
