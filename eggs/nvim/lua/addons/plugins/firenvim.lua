-- Embedded neovim in Firefox/Librewolf
-- :help firenvim
return {
    "glacambre/firenvim",

    lazy = not vim.g.started_by_firenvim,
    enabled = vim.g.started_by_firenvim,
    build = function()
        vim.fn["firenvim#install"](0)
    end,
}
