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
        },
        config = function()
            local diagnostic_signs = require("nipunlakshank.utils.icons").diagnostic_signs
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp = require("nipunlakshank.utils.cmp").get_client()

            local lsp_capabilities = require("lspconfig").util.default_config
            lsp_capabilities.capabilities = vim.tbl_deep_extend("force", lsp_capabilities.capabilities,
                cmp.capabilities())

            require("lspconfig.ui.windows").default_options.border = "rounded"

            for type, icon in pairs(diagnostic_signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
                vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
                vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<cr>", opts)
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                vim.keymap.set("n", "go", "<cmd>Lspsaga goto_type_definition<cr>", opts)
                vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", opts)
                vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
                vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
                vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
                vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
                vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)


                --[[ client.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "rounded",
                }) ]]
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- Disable underline, it's very annoying
                    underline = false,
                    virtual_text = true,
                    -- Enable virtual text, override spacing to 4
                    -- virtual_text = {spacing = 4},
                    -- Use a function to dynamically turn signs off
                    -- and on, using buffer local variables
                    signs = true,
                    update_in_insert = false
                })

            local handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
                    })
                end,

                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
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

                -- emmet
                emmet_language_server = function()
                    lspconfig.emmet_language_server.setup({
                        capabilities = lsp_capabilities,
                        on_attach = on_attach,
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
