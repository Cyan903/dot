-- Reveal hidden gremlins.
-- :help gremlins
return {
    "Cyan903/gremlins.nvim",

    opts = {},
    config = function(_, opts)
        local gremlins = require("gremlins")

        ---Open popup.
        vim.keymap.set("n", "<leader>gs", gremlins.select, { desc = "Gremlins select." })

        ---Create quickfix list.
        vim.keymap.set("n", "<leader>gc", gremlins.qflist, { desc = "Gremlins quickfix." })

        gremlins.setup(opts)
    end,
}
