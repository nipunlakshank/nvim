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

        -- Configs
        if not configs.intelephense then
            configs.intelephense = {
                default_config = {
                    cmd = { "intelephense", "--stdio" },
                    filetypes = { "php", "phtml" },
                    root_dir = function(fname)
                        return vim.loop.cwd()
                    end,
                    settings = {
                        intelephense = {
                            files = {
                                maxSize = 1000000,
                            },
                            environment = {
                                includePaths = {
                                    "/Users/nipun/dev/Sites",
                                },
                            },
                        },
                    },
                },
            }
        end


        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
}
