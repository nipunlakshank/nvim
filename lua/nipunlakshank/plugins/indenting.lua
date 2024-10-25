-- indent guides for Neovim
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "VeryLazy" },
        main = "ibl",
        config = function()
            local opts = {
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                scope = {
                    enabled = false,
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
                        "dbui",
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
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "│",
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
                    "dbui",
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
