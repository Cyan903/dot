-- Main LSP configuration
-- :help lspconfig-all
-- :Mason
return {
    "neovim/nvim-lspconfig",

    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { "williamboman/mason.nvim", config = true },

        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },

        -- Allows extra capabilities provided by nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Add to which-key menu
                require("util.safe_require")("which-key", function(key)
                    key.add({
                        { "<leader>c", group = "[C]ode (LSP)" },
                        { "<leader>cd", group = "[C]ode [D]ocument" },
                        { "<leader>cr", group = "[C]ode [R]ename" },
                        { "<leader>cw", group = "[C]ode [W]orkspace" },
                    })
                end)

                -- Jump to the definition of the word under your cursor
                -- To jump back, press <C-t>
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Jump to declaration
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Find references for the word under your cursor
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under your cursor
                map("<leader>cD", require("telescope.builtin").lsp_type_definitions, "[C]ode Type [D]efinition")

                -- Fuzzy find all the symbols in your current document
                map("<leader>cds", require("telescope.builtin").lsp_document_symbols, "[C]ode [D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace
                map("<leader>cws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[C]ode [W]orkspace [S]ymbols")

                -- Rename the variable under your cursor
                map("<leader>crn", vim.lsp.buf.rename, "[C]ode [R]e[n]ame")

                -- Execute a code action
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Disable LSP
                -- :edit - to reload
                map("<leader>cs", function()
                    vim.lsp.stop_client(vim.lsp.get_clients())
                end, "[C]ode LSP [S]top")

                -- Highlight references when the cursor idles on a definition
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                -- Enable inlay hints user command
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    vim.api.nvim_create_user_command("ToggleInlayHints", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, { desc = "Toggle inlay hints" })
                end
            end,
        })

        -- Extend the lsp's capabilities that nvim-cmp, luasnip, etc offer
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- NOTE: Servers and tools are configured here
        local servers = {
            ["termux-language-server"] = {},
            ["vue-language-server"] = {},

            clangd = {},
            gopls = {},
            bashls = {},
            angularls = {},

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
                        completion = {
                            callSnippet = "Replace",
                        },

                        diagnostics = { disable = { "missing-fields" } },
                    },
                },

                -- cmd = { ... },
                -- filetypes = {...},
                -- capabilities = {},
            },
        }

        -- NOTE: Extra tools are listed here that aren't exactly "language" servers
        local extra_servers = {
            "stylua",
            "prettierd",
            "emmet_language_server",
            "shellcheck",
        }

        require("mason").setup()

        -- Add additional dev tools
        local ensure_installed = vim.tbl_keys(servers or {})

        vim.list_extend(ensure_installed, extra_servers)

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
