-- Safe require with fallback
return function(module, fn)
    local ok, mod = pcall(require, module)

    if not ok then
        vim.print("[srequire] " .. module .. " not found!")
        return
    end

    return fn(mod)
end
