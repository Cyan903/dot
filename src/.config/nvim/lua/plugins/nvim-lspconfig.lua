-- Main LSP configuration
-- Contains nvim-lspconfig, nvim-cmp, conform, and lazydev
return {
    -- :help lspconfig-all
    -- :Mason
    {
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
                    require("util.srequire")("which-key", function(key)
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
            local lsp_cfg = require("cfg")

            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            require("mason").setup()

            -- Add additional dev tools
            local ensure_installed = vim.tbl_keys(lsp_cfg.servers or {})

            vim.list_extend(ensure_installed, lsp_cfg.tools)

            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = lsp_cfg.servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    -- Autocompletion
    -- :help cmp
    {
        "hrsh7th/nvim-cmp",

        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end

                    return "make install_jsregexp"
                end)(),

                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },

            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),

                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- Accept the completion
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    -- Force completion to open
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- Move right in the snippet
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),

                    -- Move left in the snippet
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                }),

                -- NOTE: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
                sources = {
                    {
                        name = "lazydev",
                        group_index = 0,
                    },

                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            })
        end,
    },

    -- Configures the Lua LSP for Neovim
    -- :help lazydev
    {
        "folke/lazydev.nvim",

        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
}
