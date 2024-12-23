---@diagnostic disable: unused-local
local blink = {
    url = "saghen/blink.cmp",
    spec = "nipunlakshank.plugins.completions.blink",
    capabilities = function() return require('blink.cmp').get_lsp_capabilities() end,
}
local nvim_cmp = {
    url = "hrsh7th/nvim-cmp",
    spec = "nipunlakshank.plugins.completions.nvim-cmp",
    capabilities = function() return require('blink.cmp').get_lsp_capabilities() end,
}

local active = nvim_cmp

local cmp = require("nipunlakshank.utils.cmp").set_client(active)

return {
    { blink.url,    optional = true },
    { nvim_cmp.url, optional = true },
    require(active.spec),
}
