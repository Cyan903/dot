-- mpv_websocket
-- https://github.com/kuroahna/mpv_websocket

local utils = require("mp.utils")
local options = require("mp.options")

local platform = mp.get_property_native("platform")
local opts = { port = 6677, autostart = true }

local config_file_path = mp.find_config_file("mpv.conf")
local config_folder_path, _ = utils.split_path(config_file_path)
local config_bin_path, _ = utils.join_path(config_folder_path, "bin")
local mpv_websocket_path = utils.join_path(config_bin_path, platform == "windows" and "websocket.exe" or "websocket")
local initialised_websocket

local _, err = utils.file_info(config_file_path)
if err then error("failed to open mpv config file `" .. config_file_path .. "`") end

local _, err = utils.file_info(mpv_websocket_path)
if err then error("failed to open mpv_websocket") end

options.read_options(opts, "websocket")

local function find_mpv_socket(config_file_path)
    local file = io.open(config_file_path, "r")

    if file == nil then
        error("failed to read mpv config file `" .. config_file_path .. "`")
    end

    local mpv_socket

    for line in file:lines() do
        mpv_socket = line:match("^input%-ipc%-server%s*=%s*(%g+)%s*")
        if mpv_socket then
            break
        end
    end

    file:close()

    if not mpv_socket then
        error("input-ipc-server option does not exist in `" .. config_file_path .. "`")
    end

    return mpv_socket
end

local mpv_socket = find_mpv_socket(config_file_path)

if platform == "windows" then
    mpv_socket = "\\\\.\\pipe" .. mpv_socket:gsub("/", "\\")
end

local function start_websocket()
    mp.osd_message("[websocket] server started on port " .. tostring(opts.port), 3)

    initialised_websocket = mp.command_native_async({
        name = "subprocess",
        playback_only = false,
        capture_stdout = true,
        capture_stderr = true,
        args = {
            mpv_websocket_path,
            "-m",
            mpv_socket,
            "-w",
            tostring(opts.port)
        },
    })
end

local function end_websocket()
    mp.osd_message("[websocket] server stopped", 3)
    mp.abort_async_command(initialised_websocket)

    initialised_websocket = nil
end

local function toggle_websocket()
    if initialised_websocket
        then end_websocket()
        else start_websocket()
    end
end

mp.register_script_message("togglewebsocket", toggle_websocket)

if opts.autostart then
    start_websocket()
end

