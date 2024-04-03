return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
    opts = {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
