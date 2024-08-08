-- TODO: docs

if vim.g.vscode then
    require "init.vscode"
elseif vim.g.started_by_firenvim then
    require "init.fire"
else
    require "init.nvim"
end
