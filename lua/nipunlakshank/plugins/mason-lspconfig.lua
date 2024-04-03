return {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        auto_install = true,
        ensure_installed = {
            "efm",
            "bashls",
            "tailwindcss",
            "pyright",
            "emmet_language_server",
            "jsonls",
            "lua_ls",
            "bashls",
            "tsserver",
            "intelephense",
        },
    },
}
