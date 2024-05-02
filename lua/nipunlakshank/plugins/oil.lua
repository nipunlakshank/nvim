return {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    -- Optional dependencies
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local oil = require("oil")
        local opts = {}
        oil.setup(opts)
    end,
}
