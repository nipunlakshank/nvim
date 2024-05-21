return {
    {
        "olrtg/nvim-emmet",
        ft = { "html", "php", "phtml", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "astro" },
        config = function()
            vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation, { silent = true, desc = "Emmet wrap with abbreviation" })
        end,
    },
}
