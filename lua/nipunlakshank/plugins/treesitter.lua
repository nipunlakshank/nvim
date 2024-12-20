local config = function()
    local treesitter = require("nvim-treesitter.configs")
    local parsers = require("nvim-treesitter.parsers").get_parser_configs()

    ---@diagnostic disable-next-line: inject-field
    parsers.blade = {
        install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "blade",
    }

    treesitter.setup({

        ensure_installed = {
            "lua",
            "luadoc",
            "regex",
            "jsonc",
            "markdown",
            "markdown_inline",
            "jsdoc",
            "php_only",
            "phpdoc",
            "blade",
        },

        auto_install = true,
        ignore_install = {},
        sync_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,

            disable = function(lang, buf)
                local max_filesize = 1 * 1024 * 1024 -- 1MB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then return true end
            end,
        },

        indent = { enable = true },
        modules = {},
        autotag = {
            enable = true,
            enable_rename = true,
            enable_close_on_slash = true,
        },

        endwise = {
            enable = true,
        },

        matchup = {
            enable = true, -- mandatory, false will disable the whole extension
            -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
            -- [options]
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-g>",
                node_incremental = "<C-g>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },

        textobjects = {

            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ii"] = "@conditional.inner",
                    ["ai"] = "@conditional.outer",
                    ["il"] = "@loop.inner",
                    ["al"] = "@loop.outer",
                    ["at"] = "@comment.outer",
                },
            },

            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },

            swap = {
                enable = true,
                swap_next = {
                    ["<leader>ps"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>pS"] = "@parameter.inner",
                },
            },
        },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = config,
}
