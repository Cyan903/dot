local mp = require 'mp'
local utils = require 'mp.utils'

-- Generate a unique socket path
local timestamp = os.time()
local pid = utils.getpid()
local socket_path

if package.config:sub(1, 1) == "\\" then
    -- Windows named pipe
    socket_path = "\\\\.\\pipe\\mpvpipe-" .. pid .. "-" .. timestamp
else
    -- Unix socket
    socket_path = "/tmp/mpv-" .. pid .. "-" .. timestamp .. ".sock"
end

mp.set_property("input-ipc-server", socket_path)
print("MPV IPC socket: " .. socket_path)

