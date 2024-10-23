local config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
        ensure_installed = {
            "lua",
            "regex",
            "jsonc",
            "markdown",
            "markdown_inline",
            "phpdoc",
            "jsdoc",
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
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
