return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    lazy = false,
    config = function()
        local null_ls = require("null-ls")
        local opts = {
            -- sources = {
            --     null_ls.builtins.formatting.stylua,
            --     null_ls.builtins.formatting.prettier,
            --     null_ls.builtins.formatting.black,
            --     null_ls.builtins.formatting.isort,
            --
            --     -- null_ls.builtins.diagnostics.eslint_d,
            --
            --     null_ls.builtins.completion.spell,
            -- },
            border = 'rounded',
            -- options = {
            --     insert_final_newline = true,
            --     trim_final_newlines = false,
            -- }
        }

        null_ls.setup(opts)
    end,
}
