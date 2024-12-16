local syntax_group = vim.api.nvim_create_augroup("SyntaxHighlighting", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = syntax_group,
    pattern = { "*.blade.php" },
    callback = function()
        local comment_ft = require("Comment.ft")

        comment_ft.set("blade", { "//%s", "/*%s*/" })
        vim.bo.commentstring = comment_ft.get("blade")
    end,
})
