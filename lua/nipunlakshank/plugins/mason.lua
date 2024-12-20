return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
    dependencies = {},
    config = function()
        local mason = require("mason")

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
    end,
}
