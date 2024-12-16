local signcolumn_group = vim.api.nvim_create_augroup("SignColumnGroup", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = signcolumn_group,
    pattern = { "*" },
    callback = function()
        vim.wo.signcolumn = "yes:3"
    end,
})
