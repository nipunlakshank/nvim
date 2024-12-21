-- My custom keymap module

---@class keymap.opts.key
---@field default? string
---@field mac? string
---@field linux? string
---@field windows? string

---@class keymap.opts
---@field modes string|string[]
---@field key keymap.opts.key
---@field action string|function
---@field opts table

---@class keymap.mapper
---@field modes fun(...: string): keymap.mapper
---@field key fun(lhs: string|keymap.opts.key): keymap.mapper
---@field action fun(rhs: string|function): keymap.mapper
---@field opts fun(opts: table): keymap.mapper
---@field set fun()

local M = {}

---@type keymap.opts
local keymap = {}

---@type keymap.mapper
local mapper = {}

mapper.modes = function(...)
    keymap.modes = ...
    return mapper
end

mapper.key = function(lhs)
    if type(lhs) == "string" then
        keymap.key = { default = lhs }
    else
        keymap.key = lhs
    end
    return mapper
end

mapper.action = function(rhs)
    keymap.action = rhs
    return mapper
end

mapper.opts = function(opts)
    keymap.opts = opts
    return mapper
end

local validate = function()
    if keymap.key == nil or keymap.action == nil then return false end
    if keymap.modes == nil then keymap.modes = "n" end
    if not keymap.opts then keymap.opts = {} end
    return true
end

mapper.set = function()
    if not validate() then
        bt()
        return
    end

    local platform = vim.fn.has("mac") == 1 and "mac"
        or vim.fn.has("win32") == 1 and "windows"
        or "linux"

    for pf, lhs in pairs(keymap.key) do
        if pf == platform then
            vim.keymap.set(keymap.modes, lhs, keymap.action, keymap.opts)
            return
        end
    end

    if keymap.key.default ~= nil then
        vim.keymap.set(keymap.modes, keymap.key.default, keymap.action, keymap.opts)
    end
end

--- Get merged opts with default opts
--- defaults: { buffer = true, silent = true }
---@param opts string|table
---@return table merged table
local get_opts = function(opts, defaults)
    local merged = defaults or { silent = true }
    local desc_is_set = false

    if type(opts) == "string" then
        merged.desc = opts
        return merged
    end

    for key, value in pairs(opts) do
        if type(key) == "number" then
            if desc_is_set then
                dd("invalid option: '" .. value .. "'", "error")
                bt()
                break
            end
            merged.desc = value
            desc_is_set = true
        else
            merged[key] = value
        end
    end

    return merged
end

M.mapper = mapper
M.get_opts = get_opts

return M
