return {
    "folke/neodev.nvim",
    dependencies = {
        "folke/neoconf.nvim",
    },
    config = function()
        require("neoconf").setup({})
        require("neodev").setup({})
    end,
}
