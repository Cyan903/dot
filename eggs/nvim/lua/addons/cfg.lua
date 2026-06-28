local M = {}

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

---@type table<string, vim.lsp.Config>
-- NOTE: LSP servers
M.servers = {
    ["termux-language-server"] = {},
    ["vue-language-server"] = {},
    ["vim-language-server"] = {},
    ["docker-compose-language-service"] = {},
    ["dockerfile-language-server"] = {},

    gopls = {},
    bashls = {},
    checkmake = {},
    tailwindcss = {},
    vue_ls = {},
    stylua = {},
    ruby_lsp = {},

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
        on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                    path = { "lua/?.lua", "lua/?/init.lua" },
                },

                workspace = {
                    checkThirdParty = false,
                    library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
                        "${3rd}/luv/library",
                        "${3rd}/busted/library",
                    }),
                },
            })
        end,

        settings = {
            Lua = {
                format = { enable = false },
            },
        },
    },
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

return M
