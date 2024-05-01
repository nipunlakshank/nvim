return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
        "nvimtools/none-ls.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_null_ls = require("mason-null-ls")

        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            registries = {
                "github:nvim-java/mason-registry",
                "github:mason-org/mason-registry",
            },
        })

        mason_lspconfig.setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
            },
        })

        mason_null_ls.setup({
            automatic_installation = true,
            ensure_installed = {
                "stylua",
            },
        })
    end,
}
