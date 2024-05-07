return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local diagnostic_signs = require("nipunlakshank.utils.icons").diagnostic_signs
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = require("nipunlakshank.utils.lsp").on_attach
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            require("lspconfig.ui.windows").default_options.border = "rounded"

            for type, icon in pairs(diagnostic_signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- globals = { "vim" },
                            -- disable = { "missing-parameters", "missing-fields" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("lua", true),
                       },
                    },
                },
            })

            -- php
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
                        ".htaccess",
                        ".htpasswd"
                    )(pattern)

                    if not root then
                        return cwd
                    end

                    return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant end,
                end,
            })

            -- typescript
            lspconfig.tsserver.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = {
                    "typescript",
                    "javascript",
                    "typescriptreact",
                    "javascriptreact",
                },
                commands = {
                    TypeScriptOrganizeImports = typescript_organise_imports,
                },
                settings = {
                    typescript = {
                        indentStyle = "space",
                        indentSize = 4,
                    },
                },
                root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
            })

            -- bash
            lspconfig.bashls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "sh", "zsh", "aliasrc" },
            })

            -- solidity
            lspconfig.solidity.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "solidity" },
            })

            -- java
            lspconfig.jdtls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "java" },
                cmd = { "jdtls" },
                root_dir = function(pattern)
                    local cwd = vim.loop.cwd()
                    local root = lspconfig.util.root_pattern("gradlew", ".git", "mvnw", "pom.xml")(pattern)

                    if not root then
                        return cwd
                    end

                    return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant
                end,
            })

            -- C/C++
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            })

            -- emmet
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
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                    "svelte",
                    "vue",
                    "less",
                    "sass",
                    "scss",
                    "pug",
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
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = require("nipunlakshank.utils.lsp").on_attach
            local lspconfig = require("lspconfig")

            mason_lspconfig.setup({
                automatic_installation = {
                    exclude = {
                        "clangd",
                        "solidity",
                    },
                },
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                        })
                    end,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "jay-babu/mason-null-ls.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            local mason = require("mason")
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

            mason_null_ls.setup({
                automatic_installation = true,
                ensure_installed = {
                    "stylua",
                },
            })
        end,
    },
}
