local file_exists = true
local config_path = vim.fn.stdpath("config")

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
local extras = vim.json.decode(table.concat(lines, "\n") or "", {})

local M = {}

for _, plugin_config in pairs(extras or {}) do
    local enabled = plugin_config.enabled
    local file = plugin_config.file
    local plugin_exists = vim.fn.findfile(file, config_path .. "/lua/nipunlakshank/extras") ~= ""
    local plugin_path = "nipunlakshank.extras." .. string.gsub(plugin_config.file, ".lua", "")

    if plugin_exists then
        local plugin = require(plugin_path)
        plugin.optional = plugin_config.optional and true or false
        plugin.enabled = enabled
        table.insert(M, plugin)
    end
end

return M
