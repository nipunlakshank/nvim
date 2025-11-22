return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "saghen/blink.cmp", optional = true },
            { "hrsh7th/nvim-cmp", optional = true },
            "folke/lazydev.nvim",
            "nvim-java/nvim-java",
        },
        config = function()
            local diagnostic_signs = require("nipunlakshank.utils.icons").diagnostic_signs
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp = require("nipunlakshank.utils.cmp").get_client()
            local mason_registry = require("mason-registry")

            local lsp_capabilities = require("lspconfig").util.default_config
            lsp_capabilities.capabilities =
                vim.tbl_deep_extend("force", lsp_capabilities.capabilities, cmp.capabilities())

            require("lspconfig.ui.windows").default_options.border = "rounded"

            -- for type, icon in pairs(diagnostic_signs) do
            --     local hl = "DiagnosticSign" .. type
            --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            -- end

            -- Configure how diagnostics are displayed
            vim.diagnostic.config({
                virtual_text = {
                    enable = true,
                    -- current_line = true,
                },
                -- underline = false,
                signs = {
                    text = { diagnostic_signs.ERROR, diagnostic_signs.WARN, diagnostic_signs.INFO, diagnostic_signs.HINT },
                },
            })

            local vue_ls_path = vim.fn.stdpath('data')
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

            local vue_plugin = {
                name = '@vue/typescript-plugin',
                location = vue_ls_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
            }
            local vtsls_config = {
                capabilities = lsp_capabilities,
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'vue' },
            }

            local ts_ls_config = {
                capabilities = lsp_capabilities,
                init_options = {
                    plugins = {
                        vue_plugin,
                    },
                },
                filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'vue' },
            }

            local handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,

                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        capabilities = lsp_capabilities,
                        settings = { -- custom settings for lua
                            Lua = {
                                hint = {
                                    enable = true,
                                    arrayIndex = "Disable",
                                },
                                format = {
                                    enable = true,
                                    -- formatter = "lua-format",
                                    -- formatter = "stylua",
                                },
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    -- globals = { "vim" },
                                },
                                workspace = {
                                    -- library = { vim.env.VIMRUNTIME },
                                    checkThirdParty = false,
                                },
                            },
                        },
                    })
                end,

                -- ts_ls
                ts_ls = function()
                    lspconfig.ts_ls.setup(ts_ls_config)
                end,

                -- vtsls
                vtsls = function()
                    lspconfig.vtsls.setup(vtsls_config)
                end,

                -- vue_ls
                vue_ls = function()
                    lspconfig.vue_ls.setup({
                        capabilities = lsp_capabilities,
                        filetypes = { 'vue' },
                    })
                end,

                -- nix
                nil_ls = function()
                    lspconfig.nil_ls.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            ["nil"] = {
                                formatting = {
                                    format = {
                                        command = "nixfmt",
                                    },
                                },
                            },
                        },
                    })
                end,

                -- emmet
                emmet_language_server = function()
                    lspconfig.emmet_language_server.setup({
                        capabilities = lsp_capabilities,
                        filetypes = {
                            "css",
                            "eruby",
                            "html",
                            "blade",
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
            }

            mason_lspconfig.setup({
                automatic_installation = {
                    exclude = {},
                },
                ensure_installed = {
                    "lua_ls",
                    "vimls",
                    "jsonls",
                },
                handlers = handlers,
            })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = { "LspAttach" },
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons",     -- optional
        },
    },
}
