local file_exists = true

if vim.fn.findfile("extras.json", vim.fn.stdpath("config")) == "" then
    -- print("extras.json not found, copying from extras.json.example...")
    if vim.fn.findfile("extras.json.example", vim.fn.stdpath("config")) == "" then
        -- print("extras.json.example not found, aborting...")
        return {}
    end
    vim.loop.fs_copyfile(vim.fn.stdpath("config") .. "/extras.json.example", vim.fn.stdpath("config") .. "/extras.json")
    file_exists = vim.fn.findfile("extras.json", vim.fn.stdpath("config")) ~= ""
end

if not file_exists then
    -- print("extras.json not found, aborting...")
    return {}
end

local lines = vim.fn.readfile(vim.fn.stdpath("config") .. "/extras.json", "")
local extras = vim.json.decode(table.concat(lines, "\n") or "", { luanil = { object = true, array = true } })

local M = {}

for _, plugin_config in pairs(extras or {}) do
    local enabled = plugin_config.enabled
    if enabled then
        local file = plugin_config.file
        local plugin_exists = vim.fn.findfile(file, vim.fn.stdpath("config") .. "/lua/nipunlakshank/extras") ~= ""
        -- print("Loading plugin: " .. plugin_config.plugin)
        local plugin = "nipunlakshank.extras." .. plugin_config.plugin
        if plugin_exists then
            table.insert(M, require(plugin))
        end
    end
end

return M
