local enable_logging = true

local M = {}

local sys = {}
local cmd = {}

function sys.get()
    local os_name = "linux"

    if sys.is_windows() then
        os_name = "windows"
    end
    if sys.is_mac() then
        os_name = "macos"
    end

    return os_name
end

function sys.is_unix()
    return vim.fn.has("unix") == 1
end

function sys.is_linux()
    return vim.fn.has("linux") == 1
end

function sys.is_mac()
    return vim.fn.has("mac") == 1
end

function sys.is_windows()
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

---Log a message to a file
---@param message string The message to log
---@param file ?string default: <cwd>/tmp/nvim.log
---@param opts ?log.opts default: nil
---@return nil
local function log(message, file, opts)
    if not enable_logging then
        return
    end

    local cwd = vim.fn.getcwd()

    if file == nil or file == "" then
        file = cwd .. "/tmp/nvim.log"
    end

    if vim.fn.finddir(file) ~= "" then
        file = cwd .. "/nvim.log"
    end

    opts = opts or {}

    local cmd_opts = {
        silent = "silent ",
        callback = opts.async and cmd_async or vim.cmd,
        op = opts.overwrite and " > " or " >> ",
        prefix = opts.prefix == nil and os.date("%d/%m/%y %H:%M:%S") .. "\t|\t" or opts.prefix,
        suffix = opts.suffix == nil and "" or opts.suffix,
        escape = opts.escape == nil and "-e" or (opts.escape and "-e" or ""),
        bang = opts.async and "" or "!",
    }

    if opts.silent == nil then
        cmd_opts.silent = "silent "
    elseif not opts.silent then
        cmd_opts.silent = ""
    end

    local dir = vim.fs.dirname(file)
    local final_command = cmd_opts.silent
        .. cmd_opts.bang
        .. "mkdir -p "
        .. dir
        .. " && echo "
        .. cmd_opts.escape
        .. ' "'
        .. cmd_opts.prefix
        .. message
        .. cmd_opts.suffix
        .. '"'
        .. cmd_opts.op
        .. file

    cmd_opts.callback(final_command)
end

M.sys = sys
M.cmd = cmd
M.async_cmd = cmd_async
M.log = log

return M
