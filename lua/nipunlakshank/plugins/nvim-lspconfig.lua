return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
    },
    config = function()
        require("neodev").setup({})
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
        })
        lspconfig.tsserver.setup({
            capabilities = capabilities,
        })
        lspconfig.bashls.setup({
            capabilities = capabilities,
        })
        lspconfig.intelephense.setup({
            capabilities = capabilities,
        })
        lspconfig.emmet_language_server.setup({
            filetypes = {
                "css",
                "eruby",
                "html",
                "php",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            -- **Note:** only the options listed in the table are supported.
            init_options = {
                ---@type table<string, string>
                includeLanguages = {},
                --- @type string[]
                excludeLanguages = {},
                --- @type string[]
                extensionsPath = {},
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                preferences = {},
                --- @type boolean Defaults to `true`
                showAbbreviationSuggestions = true,
                --- @type "always" | "never" Defaults to `"always"`
                showExpandedAbbreviation = "always",
                --- @type boolean Defaults to `false`
                showSuggestionsAsSnippets = true,
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                syntaxProfiles = {},
                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                variables = {},
            },
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
}
