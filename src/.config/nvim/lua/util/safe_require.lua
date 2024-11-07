-- Require with fallback
return function(module, fn)
    local ok, mod = pcall(require, module)

    if not ok then
        print("[safe_require] `" .. module .. "` not found!")
        return
    end

    return fn(mod)
end
