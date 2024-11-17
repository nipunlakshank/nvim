return {
    "haringsrob/laravel-dev-tools",
    ft = { "blade" },
    config = function()
        local configs = require("lspconfig.configs")
        local ts_parsers = require("nvim-treesitter.parsers").get_parser_configs()

        ---@diagnostic disable-next-line: inject-field
        ts_parsers.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }

        configs.blade = {
            default_config = {
                -- Path to the executable: laravel-dev-generators
                cmd = { "laravel-dev-generators", "lsp" },
                filetypes = { "blade" },
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end,
                settings = {},
            },
        }
    end,
}
