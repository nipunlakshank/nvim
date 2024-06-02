-- if vim.fn.has("nvim-0.10.0") == 1 then
if false then
    return {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            dependencies = {
                "folke/neoconf.nvim",
                { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
            },
            opts = {
                library = {
                    vim.env.LAZY .. "/luvit-meta/library",
                },
            },
        },
        { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
    }
else
    return {
        {
            "folke/neodev.nvim",
            dependencies = {
                "folke/neoconf.nvim",
            },
            config = function()
                require("neoconf").setup({})
                require("neodev").setup({})
            end,
        },
        { "folke/lazydev.nvim", enabled = false },
    }
end
