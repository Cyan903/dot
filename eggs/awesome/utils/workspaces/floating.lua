local awful = require("awful")

local mamt = 5 -- Amount in px

local function set_amt(a)
    mamt = a
end

local function move_client_to_screen(c, s)
    -- Move screen
    local index = c.first_tag.index
    c:move_to_screen(s)

    -- Move tag
    local tag = c.screen.tags[index]
    c:move_to_tag(tag)

    if tag then
        tag:view_only()
    end
end

local function move_floating(c, x, y)
    local g = c:geometry()

    if c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating then
        g.x = g.x + (x * mamt)
        g.y = g.y + (y * mamt)
    end

    c:geometry(g)
end

local function resize_floating(c, w, h)
    local g = c:geometry()

    if c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating then
        local gx = g.width + (w * mamt)
        local gy = g.height + (h * mamt)

        if gx > 0 and gy > 0 then
            g.width = gx
            g.height = gy
        end
    end

    c:geometry(g)
end

return {
    set_amt = set_amt,
    move_client_to_screen = move_client_to_screen,
    move_floating = move_floating,
    resize_floating = resize_floating,
}
