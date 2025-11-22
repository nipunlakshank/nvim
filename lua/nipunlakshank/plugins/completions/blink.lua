return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        -- "onsails/lspkind.nvim",
        "xzbdmw/colorful-menu.nvim",
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    config = function()
        local colorful_menu = require("colorful-menu")

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        local opts = {
            keymap = {
                preset = 'default',
                ['<C-k>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            appearance = {
                -- highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                -- use_nvim_cmp_as_default = false,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },

            cmdline = {
                enabled = true,
                keymap = { preset = 'cmdline' },
                completion = {
                    list = {
                        selection = {
                            -- When `true`, will automatically select the first item in the completion list
                            preselect = false,
                            -- When `true`, inserts the completion item automatically when selecting it
                            auto_insert = true,
                        },
                    },
                    -- Whether to automatically show the window when new completion items are available
                    menu = { auto_show = true },
                    -- Displays a preview of the selected item on the current line
                    ghost_text = { enabled = true }
                }
            },

            completion = {
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 50 } },
                        components = {
                            label = {
                                width = { fill = true, max = 80, min = 20 },
                                text = function(ctx)
                                    local highlights_info = colorful_menu.blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        -- Or you want to add more item to label
                                        return highlights_info.label
                                    else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights = {}
                                    local highlights_info = colorful_menu.blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        highlights = highlights_info.highlights
                                    end
                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                    end
                                    -- Do something else
                                    return highlights
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    window = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                    }
                }
            },

            sources = {
                -- add lazydev to your completion providers
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            signature = { enabled = true },
        }

        require("blink-cmp").setup(opts)
    end,

    opts_extend = { "sources.default" }
}
