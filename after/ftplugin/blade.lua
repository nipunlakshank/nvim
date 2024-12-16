local syntax_group = vim.api.nvim_create_augroup("SyntaxHighlighting", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = syntax_group,
    pattern = "*.blade.php",
    callback = function()
        local comment_ft = require("Comment.ft")
        local commentstring = { "//%s", "/*%s*/" }
        comment_ft.set("blade", commentstring)
    end,
})
