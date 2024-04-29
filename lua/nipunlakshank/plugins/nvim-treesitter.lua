local config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
        build = ":TSUpdate",
        ensure_installed = {
            "lua",
            "vim",
            "markdown",
            "markdown_inline",
            "sql",
            "html",
            "javascript",
            "typescript",
            "json",
            "yaml",
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
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
                init_selection = "<C-s>",
                node_incremental = "<C-s>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = config,
}
