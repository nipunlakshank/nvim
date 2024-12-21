return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })

        local get_option = vim.filetype.get_option
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.filetype.get_option = function(filetype, option)
            return option == "commentstring"
                and require("ts_context_commentstring.internal").calculate_commentstring()
                or get_option(filetype, option)
        end

        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
