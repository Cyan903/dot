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
