local file_exists = true
local functions = require("nipunlakshank.utils.functions")
local config_path = vim.fn.stdpath("config")
local log = functions.log

log("", "", { silent = true, async = false, prefix = "" })

if vim.fn.findfile("extras.json", config_path) == "" then
    if vim.fn.findfile("extras.json.example", config_path) == "" then
        return {}
    end
    vim.loop.fs_copyfile(config_path .. "/extras.json.example", config_path .. "/extras.json")
    file_exists = vim.fn.findfile("extras.json", config_path) ~= ""
end

if not file_exists then
    return {}
end

local lines = vim.fn.readfile(config_path .. "/extras.json", "")
local extras = vim.json.decode(table.concat(lines, "\n") or "", { luanil = { object = true, array = true } })

local M = {}

for _, plugin_config in pairs(extras or {}) do
    local enabled = plugin_config.enabled
    local file = plugin_config.file
    local plugin_exists = vim.fn.findfile(file, config_path .. "/lua/nipunlakshank/extras") ~= ""
    local plugin_path = "nipunlakshank.extras." .. plugin_config.plugin

    if plugin_exists then
        log("Before requiring " .. plugin_config.plugin, "", { silent = true, async = false })
        local plugin = require(plugin_path)
        log("After requiring " .. plugin_config.plugin, "", { silent = true, async = false })
        plugin.optional = plugin_config.optional and true or false
        plugin.enabled = enabled
        table.insert(M, plugin)
        log("Inserted to spec " .. plugin_config.plugin, "", { silent = true, async = false })
    end
end

return M
