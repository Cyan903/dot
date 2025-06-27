--
-- Directory Structure
--
-- ├── addons/      -- External addons loaded by a plugin manager.
-- │   ├── plugins/ -- External plugins.
-- │   ├── themes/  -- External themes.
-- │   └── cfg.lua  -- Language-specific plugin configurations (e.g., LSP).
-- ├── core/        -- Core config specific to Neovim.
-- │   ├── config/  -- Standard configuration items (e.g., autocmd, set, etc...).
-- │   ├── init/    -- Different `init.lua` scripts depending on how Neovim is launche.
-- │   └── user/    -- Custom modules that are not reliant on external plugin.
-- └── util/        -- Utility functions used throughout the config.
--

require("util.init")({
    { "vscode", vim.g.vscode },
    { "fire", vim.g.started_by_firenvim },
})
