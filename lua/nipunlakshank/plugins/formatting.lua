return {
    'stevearc/conform.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua", lsp_format = "prefer" },
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettierd", "prettier", lsp_format = "prefer", stop_after_first = true },
                blade = { "blade-formatter", "pint", stop_after_first = true },
                php = { "pint", lsp_format = "prefer", stop_after_first = true },
                html = { "prettierd", "prettier", lsp_format = "prefer", stop_after_first = true },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end
}
