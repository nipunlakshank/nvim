return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    enabled = vim.fn.has("nvim-0.10.0") == 0,
}
