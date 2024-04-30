return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    lazy = false,
    config = function()
        local null_ls = require("null-ls")
        local opts = {
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.shfmt,

                null_ls.builtins.completion.spell,

                require("none-ls.diagnostics.eslint_d"),
            },
            border = "rounded",
        }

        null_ls.setup(opts)
    end,
}
