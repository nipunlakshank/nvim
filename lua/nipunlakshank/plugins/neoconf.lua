return {
    "folke/neoconf.nvim",
    dependencies = {
        "folke/neodev.nvim",
    },
    config = function ()
        require("neodev").setup({})
        require("neoconf").setup({})
    end
}
