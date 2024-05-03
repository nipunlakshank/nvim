local M = {
    {
        "folke/neoconf.nvim",
        dependencies = {
            "folke/neodev.nvim",
        },
        config = function()
            require("neoconf").setup({})
        end,
    },
}

local extras = require("nipunlakshank.config.extras")
M = vim.tbl_extend("force", M, extras)

return M
