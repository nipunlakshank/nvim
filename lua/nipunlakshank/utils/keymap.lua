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

---@type keymap
local keymap = {}

---@type mapper
local M = {}

M.modes = function(...)
    keymap.modes = ...
    return M
end

M.lhs = function(lhs)
    if type(lhs) == "string" then
        keymap.lhs = { default = lhs }
    else
        keymap.lhs = lhs
    end
    return M
end

M.rhs = function(rhs)
    keymap.rhs = rhs
    return M
end

M.opts = function(opts)
    keymap.opts = opts
    return M
end

local validate = function()
    if keymap.lhs == nil or keymap.rhs == nil then return false end
    if keymap.modes == nil then keymap.modes = "n" end
    if not keymap.opts then keymap.opts = {} end
    return true
end

M.set = function()
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

return M
