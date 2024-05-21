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
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.gitlint,

                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "css",
                        "scss",
                        "json",
                        "yaml",
                        "html",
                        "vue",
                        "svelte",
                        "less",
                        "angular",
                        "flow",
                        "javascript",
                        -- "markdown",
                    },
                }),

                null_ls.builtins.formatting.shfmt.with({
                    filetypes = {
                        "sh",
                        "zsh",
                    },
                }),

                -- require("none-ls.formatting.rustfmt"),
            },
            border = "rounded",
        }

        null_ls.setup(opts)
    end,
}
