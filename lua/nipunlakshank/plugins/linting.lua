return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            -- lua = { "luacheck" },
        }

        vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
