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
    tailwindcss = {},

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

    vue_ls = {},

    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
}

-- NOTE: Extra LSP tools
M.tools = {
    "stylua",
    "prettierd",
    "shellcheck",
    "ruff",
    "vue-language-server",
}

-- NOTE: Treesitter parsers
M.treesitter = {
    ensure_installed = { "bash", "awk", "c", "html" },
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
        vue = { "prettierd", "prettier", stop_after_first = true },
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

M.autocmds = function(servers, capabilities)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "vue",
        callback = function(args)
            local root_dir = vim.fs.root(args.buf, { "package.json", "tsconfig.json", "jsconfig.json" })
            local init_options = vim.deepcopy(servers.ts_ls.init_options)

            -- Ensure plugin location is set
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
            if vim.fn.isdirectory(mason_path) == 1 then
                init_options.plugins[1].location = mason_path
            end

            vim.lsp.start({
                name = "ts_ls",
                cmd = { "typescript-language-server", "--stdio" },
                root_dir = root_dir,
                init_options = init_options,
                capabilities = capabilities,
            })
        end,
    })
end

return M
