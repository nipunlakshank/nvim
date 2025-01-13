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
            "html",
            "php",
            "javascript",
            "blade",
            "css",
            "tsx",
        },

        auto_install = true,
        ignore_install = {},
        sync_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "blade", "php" },

            ---@diagnostic disable-next-line: unused-local
            disable = function(lang, buf)
                local max_filesize = 1 * 1024 * 1024 -- 1MB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then return true end
            end,
        },

        indent = { enable = true },
        modules = {},

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
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },

            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },

            lsp_interop = {
                enable = true,
                border = 'rounded',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dc"] = "@class.outer",
                    ["<leader>dl"] = "@loop.outer",
                    ["<leader>di"] = "@conditional.outer",
                },
            },
        },
    })

    require('nvim-ts-autotag').setup({
        opts = {
            -- Defaults
            enable_close = true,         -- Auto close tags
            enable_rename = true,        -- Auto rename pairs of tags
            enable_close_on_slash = true -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
            -- ["html"] = {
            --     enable_close = false
            -- },
        }
    })

    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = config,
}
