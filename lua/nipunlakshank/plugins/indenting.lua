-- indent guides for Neovim
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        config = function()
            -- local highlight = {
            --     "RainbowRed",
            --     "RainbowYellow",
            --     "RainbowBlue",
            --     "RainbowOrange",
            --     "RainbowGreen",
            --     "RainbowViolet",
            --     "RainbowCyan",
            -- }
            --
            -- local hooks = require("ibl.hooks")
            -- -- create the highlight groups in the highlight setup hook, so they are reset
            -- -- every time the colorscheme changes
            -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            --     vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            --     vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            --     vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            --     vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            --     vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            --     vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            --     vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            -- end)

            local opts = {
                indent = {
                    char = "│",
                    tab_char = "│",
                    -- highlight = highlight,
                },
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                        "lazyterm",
                    },
                },
            }
            require("ibl").setup(opts)
        end,
    },

    -- Active indent guide and indent text objects. When you're browsing
    -- code, this highlights the current level of indentation, and animates
    -- the highlighting.
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "VeryLazy",
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = true,
    },
}
