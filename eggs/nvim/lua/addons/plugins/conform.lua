-- Autoformat
-- :help conform
return {
    "stevearc/conform.nvim",

    -- event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,

            mode = "",
            desc = "[F]ormat buffer",
        },
    },

    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            return {
                timeout_ms = 500,
                lsp_fallback = not require("addons.cfg").format.ft[vim.bo[bufnr].filetype],
            }
        end,

        formatters_by_ft = vim.tbl_deep_extend("force", {
            lua = { "stylua" },
        }, require("addons.cfg").format.ft),
    },
}
