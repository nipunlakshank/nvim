return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neodev.nvim", optional = true },
            { "folke/lazydev.nvim", optional = true },
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

            -- lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
                        format = {
                            enable = false,
                            -- formatter = "lua-format",
                            -- formatter = "stylua",
                        },
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

            -- nix
            lspconfig.nil_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "nix" },
                cmd = { "nil" },
                settings = {
                    ['nil'] = {
                        formatting = { command = { "nixfmt" } },
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
                        ".git",
                        ".gitignore",
                        ".env",
                        ".env.example",
                        "composer.json",
                        "composer.lock",
                        "composer.yaml"
                    )(pattern)

                    if not root then
                        return cwd
                    end

                    return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant end,
                end,
            })

            -- typescript
            lspconfig.ts_ls.setup({
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
                filetypes = { "sh", "bash", "zsh", "aliasrc" },
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
            local util = require("lspconfig.util")

            mason_lspconfig.setup({
                automatic_installation = {
                    exclude = {
                        "clangd",
                        "solidity",
                    },
                },
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
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

                    -- java
                    jdtls = function()
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
                    end,

                    -- C/C++
                    clangd = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--offset-encoding=utf-16",
                            },
                            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
                        })
                    end,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
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
