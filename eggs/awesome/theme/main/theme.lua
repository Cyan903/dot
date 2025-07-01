local gears = require("gears")
local rnotification = require("ruled.notification")
local dpi = require("beautiful.xresources").apply_dpi

local theme = {}
local themes_path = gears.filesystem.get_dir("config") .. "theme/main/"

theme.wallpaper = nil
theme.font = "FreeMono 8"
theme.font_bold = "FreeMono Bold 8"

local function bg_check(name)
    local f = io.open(name, "r")

    if f ~= nil then
        io.close(f)
        return true
    end

    return false
end

theme.bg_normal = "#1e2029" -- {< replace_color(data.colors.wallpaper) >}
theme.bg_focus = "#282a36" -- {< replace_color(data.colors.background) >}
theme.bg_urgent = "#ff5555" -- {< replace_color(data.colors.red) >}
theme.bg_minimize = "#000000" -- {< replace_color(data.colors.dark) >}
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#f8f8f2" -- {< replace_color(data.colors.foreground) >}
theme.fg_focus = "#ffffff" -- {< replace_color(data.colors.bright) >}
theme.fg_urgent = "#f8f8f2" -- {< replace_color(data.colors.foreground) >}

-- Borders
theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_color_normal = theme.bg_normal
theme.border_color_active = "#bd93f9" -- {< replace_color(data.colors.primary) >}
theme.border_color_marked = "#ff79c6" -- {< replace_color(data.colors.magenta) >}

theme.primary = "#bd93f9" -- {< replace_color(data.colors.primary) >}
theme.bright = "#ffffff" -- {< replace_color(data.colors.bright) >}
theme.red = "#ff5555" -- {< replace_color(data.colors.red) >}

-- Titlebars
theme.titlebar_bg_focus = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_focus
theme.taglist_bg_focus = theme.bg_normal

-- Hotkeys
theme.hotkeys_modifiers_fg = "#ffffff" -- {< replace_color(data.colors.bright) >}
theme.hotkeys_border_color = theme.border_color_active

-- Menu
theme.menu_height = dpi(25)
theme.menu_width = dpi(125)

-- Icons
theme.taglist_squares_sel = gears.color.recolor_image(themes_path .. "taglist/squarefz.png", theme.border_color_active)
theme.taglist_squares_unsel = gears.color.recolor_image(themes_path .. "taglist/squarez.png", theme.border_color_active)
-- theme.taglist_squares_resize = "false"

-- Layout
theme.layout_tile = gears.color.recolor_image(themes_path .. "layouts/tile.png", theme.primary)
theme.layout_tileleft = gears.color.recolor_image(themes_path .. "layouts/tileleft.png", theme.primary)
theme.layout_tilebottom = gears.color.recolor_image(themes_path .. "layouts/tilebottom.png", theme.primary)
theme.layout_tiletop = gears.color.recolor_image(themes_path .. "layouts/tiletop.png", theme.primary)
theme.layout_fairv = gears.color.recolor_image(themes_path .. "layouts/fairv.png", theme.primary)
theme.layout_fairh = gears.color.recolor_image(themes_path .. "layouts/fairh.png", theme.primary)
theme.layout_spiral = gears.color.recolor_image(themes_path .. "layouts/spiral.png", theme.primary)
theme.layout_dwindle = gears.color.recolor_image(themes_path .. "layouts/dwindle.png", theme.primary)
theme.layout_max = gears.color.recolor_image(themes_path .. "layouts/max.png", theme.primary)
theme.layout_fullscreen = gears.color.recolor_image(themes_path .. "layouts/fullscreen.png", theme.primary)
theme.layout_magnifier = gears.color.recolor_image(themes_path .. "layouts/magnifier.png", theme.primary)
theme.layout_floating = gears.color.recolor_image(themes_path .. "layouts/floating.png", theme.primary)
theme.layout_cornernw = gears.color.recolor_image(themes_path .. "layouts/cornernw.png", theme.primary)
theme.layout_cornerne = gears.color.recolor_image(themes_path .. "layouts/cornerne.png", theme.primary)
theme.layout_cornersw = gears.color.recolor_image(themes_path .. "layouts/cornersw.png", theme.primary)
theme.layout_cornerse = gears.color.recolor_image(themes_path .. "layouts/cornerse.png", theme.primary)

-- Set different colors for urgent notifications
rnotification.connect_signal("request::rules", function()
    rnotification.append_rule({
        rule = { urgency = "critical" },
        properties = { bg = theme.bg_urgent, fg = theme.fg_urgent },
    })

    rnotification.append_rule({
        rule = { urgency = "low" },
        properties = { bg = theme.bg_focus .. "90", fg = theme.fg_urgent },
    })
end)

-- Set the background if the image exists
if bg_check(themes_path .. "bg") then
    theme.wallpaper = themes_path .. "/bg"
end

return theme
