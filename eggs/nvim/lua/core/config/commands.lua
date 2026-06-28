--- Auto Commands
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

--- User Commands
-- Toggle word wrapping and remap jk
vim.api.nvim_create_user_command("WordWrapToggle", function()
    vim.cmd([[
        set wrap!

        if &wrap
            noremap j gj
            noremap k gk
            set norelativenumber
        else
            unmap j
            unmap k
            set relativenumber
        endif
    ]])
end, { desc = "Toggle word wrapping on a file" })

