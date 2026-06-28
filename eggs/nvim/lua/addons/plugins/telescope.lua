local pack = require("utils.pack")

pack.install({
    source = { pack.gh "nvim-telescope/telescope.nvim" },
    enabled = true,

    dependencies = {
        {
            source = { pack.gh "nvim-lua/plenary.nvim" },
            enabled = true,
            callback = function() end
        },

        {
            source = { pack.gh "nvim-telescope/telescope-ui-select.nvim" },
            enabled = true,
            callback = function() end
        },

        {
            source = { pack.gh "nvim-telescope/telescope-fzf-native.nvim" },
            enabled = vim.fn.executable("make") == 1,
            callback = function() end
        }
    },

    -- Fuzzy finder
    -- :help telescope
    callback = function()
        local telescope = require("telescope")
        local themes = require("telescope.themes")

        -- Add to which-key menu
        require("utils.require")("which-key", function(key)
            key.add({
                { "<leader>s", group = "[S]earch (telescope)" },
                { "<leader>g", group = "[G]it (telescope)" },
            })
        end)

        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        telescope.setup({
            extensions = {
                ["ui-select"] = {
                    themes.get_dropdown(),
                },
            },

            defaults = {
                file_ignore_patterns = vim.list_extend({
                    ".git/",
                    ".cache/",
                    ".deployed_cache/",
                }, require("addons.cfg").ignore),
            },

            pickers = {
                find_files = { hidden = true },
                grep_string = { additional_args = { "--hidden" } },
                live_grep = { additional_args = { "--hidden" } },
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "ui-select")

        -- :help telescope.builtin
        local builtin = require("telescope.builtin")

        -- builtin.search
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- builtin.git
        vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "[G]it [L]og" })
        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "[G]it [B]ranch" })

        -- Search through current file
        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        -- Search through current file (live grep)
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
    end
})
