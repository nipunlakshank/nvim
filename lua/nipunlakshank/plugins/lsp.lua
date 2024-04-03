return {
    {
        "olrtg/nvim-emmet",
        lazy = false,
        config = function()
            vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
        end,
    },
}
