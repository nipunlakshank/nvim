return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    -- NOTE: this was enabled again due to ts-comments not replacing the same functionality but enhancing native comments
    -- enabled = vim.fn.has("nvim-0.10.0") == 0,
}
