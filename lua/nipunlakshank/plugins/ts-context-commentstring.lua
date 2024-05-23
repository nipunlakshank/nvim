return {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("ts_context_commentstring").setup({})
    end,
}
