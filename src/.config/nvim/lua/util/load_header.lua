-- Read random header from `./header`
return function()
    local config_path = os.getenv("NVIM_CONFIG_DIR") or "~/.config/nvim"
    local content = vim.split(vim.fn.glob(config_path .. "/header/*"), "\n", { trimempty = true })

    if not content or #content <= 0 then
        print("[load_header] Header directory not found or empty!")
        return {}
    end

    math.randomseed(os.time())

    -- Select & read random header
    local f = assert(io.open(content[math.random(#content)], "rb"))
    local text = f:read("*all")

    f:close()

    return vim.split(text, "\n")
end
