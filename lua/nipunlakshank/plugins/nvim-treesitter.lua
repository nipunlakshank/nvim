local config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
        build = ":TSUpdate",
        ensure_installed = {
            "lua",
            "regex",
            "markdown",
            "markdown_inline",
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
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = config,
}
