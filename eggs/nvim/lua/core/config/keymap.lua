-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "[Q]uickfix [D]iagnostic list" })

-- Quickfix keymaps
vim.keymap.set("n", "<leader>qq", function()
    local qf_exists = false

    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end

    if qf_exists then
        vim.cmd("cclose")
        return
    end

    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd("copen")
    end
end, { desc = "[Q]uickfix toggle" })

vim.cmd([[
    nnoremap <M-j> <cmd>cnext<cr>
    nnoremap <M-k> <cmd>cprev<cr>
]])

-- Delete word with CTRL + Backspace
vim.keymap.set("i", "<C-backspace>", "<C-w>")

-- Better split navigation keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- default is <C-\><C-n>

-- Split keymaps
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-]>", "<C-W>+")
vim.keymap.set("n", "<M-[>", "<C-W>-")
