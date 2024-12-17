local M = {}

local config = require("tailwind-tools.config")
local utils = require("tailwind-tools.utils")
local icons = require("nipunlakshank.utils.icons").cmp_icons

-- NOTE: cmp is not used here, but it is shown to lazy load (by lazydev.nvim) types
-- local cmp = require("cmp")

-- Formatting utility for https://github.com/onsails/lspkind.nvim
---@param entry cmp.Entry
---@param vim_item any
---@return any
M.format = function(entry, vim_item)
    local doc = entry.completion_item.documentation

    -- tailwindcss
    if vim_item.kind == "Color" and doc then
        local content = type(doc) == "string" and doc or doc.value
        local r, g, b = utils.extract_color(content)
        local style = config.options.cmp.highlight

        if r then
            vim_item.kind_hl_group = utils.set_hl_from(r, g, b, style)
        end
    end

    -- nvim-html-css
    if entry.source.name == "html-css" then
        vim_item.menu = entry.completion_item.kind
    end

    -- nvim-lsp
    if entry.source.name == "nvim_lsp" and vim_item.kind == "Text" then
        vim_item.kind = "Emmet"
    end

    -- blade-nav
    if vim_item.kind == "BladeNav" then
        vim_item.kind_hl_group = utils.set_hl_from(243, 139, 169, "inline")
    end

    -- icons
    if icons[vim_item.kind] then
        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
    end

    return vim_item
end

return M
