return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        local opts = {
            sources = {
                null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,

                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "css",
                        "scss",
                        "json",
                        "yaml",
                        "markdown",
                        "html",
                        "vue",
                        "svelte",
                        "less",
                        "angular",
                        "flow",
                        "javascript",
                    },
                }),

                null_ls.builtins.formatting.shfmt.with({
                    filetypes = {
                        "sh",
                        "zsh",
                        "bash",
                    },
                }),

                require("none-ls.formatting.rustfmt"),
            },
            border = "rounded",
        }

        null_ls.setup(opts)
    end,
}
