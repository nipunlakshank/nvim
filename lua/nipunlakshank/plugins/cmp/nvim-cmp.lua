return {
    "hrsh7th/nvim-cmp",
    event = "BufReadPost",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind.nvim",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local lspkind = require("lspkind")
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local utils = require("nipunlakshank.utils.cmp")

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                format = lspkind.cmp_format({
                    --[[ menu = { -- showing type in menu
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        buffer = "[Buffer]",
                        luasnip = "[LuaSnip]",
                        vim_dadbod_completion = "[DB]",
                    }, ]]
                    -- mode = "symbol", -- show only symbol annotations
                    -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- can also be a function to dynamically calculate max width such as
                    maxwidth = function()
                        return math.floor(0.40 * vim.o.columns)
                    end,
                    ellipsis_char = "...",     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = false, -- show labelDetails in menu. Disabled by default

                    -- The function below will be called before any actual modifications from lspkind
                    --- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    --[[ before = function(entry, vim_item)
                        return vim_item
                    end, ]]
                    before = utils.format,
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "buffer",   priority = 500 },
                { name = "path",     priority = 250 },
                {
                    name = "html-css",
                    option = {
                        -- your configuration here
                        enable_on = {
                            "html",
                            "php",
                            "blade",
                        },                                                   -- set the file types you want the plugin to work on
                        dir_to_exclude = { "node_modules" },
                        file_extensions = { "css", "sass", "less", "scss" }, -- set the local filetypes from which you want to derive classes
                        style_sheets = {
                            -- example of remote styles, only css no js for now
                            "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
                            -- "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
                        },
                    },
                    priority = 550,
                },
            }, {
                { name = "buffer" },
            }),
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = "buffer" },
            }),
        })
        cmp.setup.filetype({ "sql", "mysql" }, {
            sources = cmp.config.sources({
                { name = "vim-dadbod-completion", priority = 1000 },
                { name = "buffer",                priority = 750 },
                { name = "path",                  priority = 500 },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "cmdline", priority = 1000 },
                { name = "path",    priority = 900 },
            }),
        })

        vim.keymap.set({ "i", "s" }, "<C-y>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { silent = true })
    end,
}
