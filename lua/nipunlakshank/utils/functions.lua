local enable_logging = true

local M = {}

local os = {}
local cmd = {}

function os.get()
    local os_name = "linux"

    if os.is_windows() then
        os_name = "windows"
    end
    if os.is_mac() then
        os_name = "macos"
    end

    return os_name
end

function os.is_unix()
    return vim.fn.has("unix") == 1
end

function os.is_linux()
    return vim.fn.has("linux") == 1
end

function os.is_mac()
    return vim.fn.has("mac") == 1
end

function os.is_windows()
    return vim.fn.has("win32") == 1
end

-- Function to retrieve console output
function cmd.capture(command, raw)
    local handle = assert(io.popen(command, "r"))
    local output = assert(handle:read("*a"))

    handle:close()

    if raw then
        return output
    end

    output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")
    return output
end

---@param command string
---@param on_exit function | nil
---@return number
local function cmd_async(command, on_exit)
    return vim.fn.jobstart(command, {
        cwd = vim.fn.getcwd(),
        on_exit = on_exit or function(_, exit_code, _)
            return exit_code
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
end

---@class log.opts
---@field silent boolean default: true If true, the command will be executed silently
---@field async boolean default: false If true, the command will be executed asynchronously
---@field overwrite boolean default: false If true, the file will be overwritten
---@field prefix string default: current time. The string to prepend to the message
---@field suffix string default: "" The string to append to the message
---@field escape boolean default: true If true, the message will be escaped

---@param message string The message to log
---@param file ?string default: <cwd>/tmp/nvim.log
---@param opts ?log.opts
---@return nil
---@description Log a message to a file
local function log(message, file, opts)
    if not enable_logging then
        return
    end

    local cwd = vim.fn.getcwd()

    if file == nil or file == "" then
        file = cwd .. "/tmp/nvim.log"
    end

    if vim.fn.finddir(file) ~= "" then
        file = file .. "/nvim.log"
    end

    opts = opts or {}

    local log_opts = {
        silent = "silent ",
        callback = opts.async and cmd_async or vim.cmd,
        op = opts.overwrite and " > " or " >> ",
        prefix = opts.prefix == nil and os.date("%d/%m/%y %H:%M:%S") .. "\t|\t" or opts.prefix,
        suffix = opts.suffix == nil and "" or opts.suffix,
        escape = opts.escape == nil and "-e" or (opts.escape and "-e" or ""),
        bang = opts.async and "" or "!",
    }

    if opts.silent == nil then
        log_opts.silent = "silent "
    elseif not opts.silent then
        log_opts.silent = ""
    end

    local dir = vim.fs.dirname(file)
    local final_command = log_opts.silent
        .. log_opts.bang
        .. "mkdir -p "
        .. dir
        .. " && echo "
        .. log_opts.escape
        .. ' "'
        .. log_opts.prefix
        .. message
        .. log_opts.suffix
        .. '"'
        .. log_opts.op
        .. file

    log_opts.callback(final_command)
end

M.os = os
M.cmd = cmd
M.async_cmd = cmd_async
M.log = log

return M
