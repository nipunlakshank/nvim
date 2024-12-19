local ft_group = vim.api.nvim_create_augroup("FiletypeGroup", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = ft_group,
    pattern = "*.blade.php",
    callback = function()
        local comment_ft = require("Comment.ft")
        local commentstring = { "//%s", "/*%s*/" }
        if comment_ft then
            comment_ft.set("blade", commentstring)
        else
            vim.bo.commentstring = table.concat(commentstring, ",")
        end
    end,
})
