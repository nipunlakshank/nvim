-- indent guides for Neovim
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "FileType",
        main = "ibl",
        config = function()
            local scope = "focus"
            local indent = "passive"

            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "focus", { fg = "#7486bd" })
                vim.api.nvim_set_hl(0, "passive", { fg = "#41425e" })
            end)

            local opts = {
                indent = {
                    char = "│",
                    tab_char = "│",
                    highlight = indent,
                },
                scope = {
                    enabled = false,
                    highlight = scope,
                },
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
        event = { "FileType" },
        opts = {
            symbol = "│",
            -- symbol = "▏",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("IndentScopeGroup", {}),
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
                    ---@diagnostic disable-next-line: inject-field
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = true,
    },
}
