---@diagnostic disable: undefined-doc-name, undefined-field, assign-type-mismatch, missing-parameter, param-type-mismatch
local M = {}

-- Formatting utility for https://github.com/onsails/lspkind.nvim
---@module "cmp"
---@param entry cmp.Entry
---@param vim_item any
---@return any
local format = function(entry, vim_item)
    local config = require("tailwind-tools.config")
    local tw_utils = require("tailwind-tools.utils")
    local icons = require("nipunlakshank.utils.icons").cmp_icons
    local doc = entry.completion_item.documentation
    local utils = require("nipunlakshank.utils")

    -- tailwindcss
    if vim_item.kind == "Color" and doc then
        local content = type(doc) == "string" and doc or doc.value
        local r, g, b = tw_utils.extract_color(content)
        local style = config.options.cmp.highlight

        if r then
            vim_item.kind_hl_group = tw_utils.set_hl_from(r, g, b, style)
        end
    end

    -- nvim-html-css
    if entry.source.name == "html-css" then
        vim_item.menu = entry.completion_item.kind
    end

    -- nvim-lsp
    if utils.array.contains(entry.context.filetype, { "html", "php", "blade", "astro" }) then
        if entry.source.name == "nvim_lsp" and vim_item.kind == "Text" then
            vim_item.kind = "Emmet"
        end
    end

    -- blade-nav
    if vim_item.kind == "BladeNav" then
        vim_item.kind_hl_group = tw_utils.set_hl_from(243, 139, 169, "inline")
    end

    -- icons
    if icons[vim_item.kind] then
        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
    end

    return vim_item
end


---@class active_client
---@field url string repo url of the plugin
---@field spec string? path to plugin spec
---@field capabilites fun():table get lsp capabilities for active client
local active_client = {
    url = "",
    spec = "",
    capabilities = function() return {} end,
    get_client = function() return {} end,
}

---@param url active_client.url?
---@param spec active_client.spec?
---@param capabilities active_client.capabilities?
---@return active_client
function active_client:new(url, spec, capabilities)
    active_client = active_client or {}
    setmetatable(active_client, self)
    self.__index = self
    self.url = url or self.url
    self.spec = spec or self.spec
    self.capabilities = capabilities or self.capabilities
    return active_client
end

---@param client active_client active cmp client
local set_client = function(client)
    active_client = active_client:new(client)
    _G.cmp_client = active_client
end


M.format = format
M.set_client = set_client
M.get_client = function() return _G.cmp_client or nil end

return M
