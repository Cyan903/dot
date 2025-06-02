-- Retrieves all keybindings for the mouse, keyboard, and active applications across both clients and the wm
return {
    active = require(... .. ".active"),
    global = require(... .. ".global"),
    client = require(... .. ".client"),
}
