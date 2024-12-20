-- My custom keymap module

---@class lhs_map
---@field default string
---@field mac string
---@field linux string
---@field windows string

---@class keymap
---@field modes string|string[]
---@field lhs lhs_map
---@field rhs string|function
---@field opts table

---@class mapper
---@field modes fun(...: string): mapper
---@field lhs fun(lhs: string|lhs_map): mapper
---@field rhs fun(rhs: string|function): mapper
---@field opts fun(opts: table): mapper
---@field set fun()

local M = {}

---@type keymap
local keymap = {}

---@type mapper
local mapper = {}

mapper.modes = function(...)
    keymap.modes = ...
    return mapper
end

mapper.lhs = function(lhs)
    if type(lhs) == "string" then
        keymap.lhs = { default = lhs }
    else
        keymap.lhs = lhs
    end
    return mapper
end

mapper.rhs = function(rhs)
    keymap.rhs = rhs
    return mapper
end

mapper.opts = function(opts)
    keymap.opts = opts
    return mapper
end

local validate = function()
    if keymap.lhs == nil or keymap.rhs == nil then return false end
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

    for pf, lhs in pairs(keymap.lhs) do
        if pf == platform then
            vim.keymap.set(keymap.modes, lhs, keymap.rhs, keymap.opts)
            return
        end
    end

    if keymap.lhs.default ~= nil then
        vim.keymap.set(keymap.modes, keymap.lhs.default, keymap.rhs, keymap.opts)
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
