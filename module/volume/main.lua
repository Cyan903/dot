local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local ICON_DIR = gears.filesystem.get_dir("config") .. "module/volume/icons/"
local BIN_DIR = gears.filesystem.get_dir("config") .. "module/volume/bin/"

-- Helper functions
local rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
end