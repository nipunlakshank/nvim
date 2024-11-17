-- configuration for .env files

local syntax_group = vim.api.nvim_create_augroup('SyntaxHighlighting', {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = syntax_group,
    pattern = { "*.env", "*.env.*" },
    callback = function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        if string.endswith(buf_name, ".example") then
            vim.bo.syntax = 'confini'
            return
        end
        vim.bo.syntax = 'config'
    end,
})
