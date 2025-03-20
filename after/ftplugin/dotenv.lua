-- configuration for .env files

local ft_group = vim.api.nvim_create_augroup("FiletypeGroup", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = ft_group,
    buffer = 0,
    callback = function()
        -- local buf_name = vim.api.nvim_buf_get_name(0)

        vim.bo.commentstring = "# %s"

        --[[ if string.endswith(buf_name, ".example") then
            vim.bo.syntax = "confini"
            return
        end ]]
        vim.bo.syntax = "sh"
    end,
})
