return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
    },
    config = function()
        require("neodev").setup({})
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local on_attach = require("nipunlakshank.utils.lsp").on_attach
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")
        local util = require("lspconfig.util")

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.bashls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.intelephense.setup({
            capabilities = capabilities,
            on_attach = on_attach,

            root_dir = function(pattern)
                local cwd = vim.loop.cwd()
                local root = util.root_pattern(
                    "composer.json",
                    ".git",
                    ".gitignore",
                    ".env",
                    ".env.example",
                    "package.json",
                    "yarn.lock",
                    "node_modules",
                    ".htaccess",
                    ".htpasswd"
                )(pattern)

                if not root then
                    root = cwd
                end
                return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant
            end,
        })

        lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "css",
                "eruby",
                "html",
                "php",
                "phtml",
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
    end,
}
