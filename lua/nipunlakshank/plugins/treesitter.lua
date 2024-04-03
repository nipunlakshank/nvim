return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",

    conifg = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            modules = {},
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close_on_slash = true,
            },
            endwise = {
                enable = true,
            },
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            ensure_installed = {
                "lua",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
