local M = {}

-- NOTE: LSP servers
M.servers = {
    ["termux-language-server"] = {},
    ["vue-language-server"] = {},
    ["vim-language-server"] = {},
    ["docker-compose-language-service"] = {},
    ["dockerfile-language-server"] = {},

    clangd = {},
    gopls = {},
    bashls = {},
    angularls = {},
    checkmake = {},

    pylsp = {
        settings = {
            plugins = {
                pylsp_mypy = {
                    enabled = true,
                    report_progress = true,
                    live_mode = true,
                },
            },
        },
    },

    ts_ls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
                },
            },
        },
    },

    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { disable = { "missing-fields" } },
            },
        },

        -- cmd = { ... },
        -- filetypes = {...},
        -- capabilities = {},
    },
}

-- NOTE: Extra LSP tools are listed here that aren't exactly "language" servers
M.tools = {
    "stylua",
    "prettierd",
    "emmet_language_server",
    "shellcheck",
    "ruff",
}

-- NOTE: Treesitter parsers
M.treesitter = {
    ensure_installed = { "bash", "awk", "c" },
    indent_disable = { "ruby" },
    vim_regex = { "ruby" },
}

-- NOTE: Format options
M.format = {
    disabled = { c = true, cpp = true },

    ft = {
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        python = { "isort", "black", stop_after_first = true },
    },
}

-- NOTE: Telescope ignore
M.ignore = {
    "node_modules/",
    "vendor/",
    "%.o",
    "%.a",
    "%.out",
    "%.class",
    "%.zip",
}

return M
