return {
    "olrtg/nvim-emmet",
    ft = {
        "html",
        "phtml",
        "css",
        "scss",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "astro",
        "blade",
    },
    config = function()
        vim.keymap.set(
            { "n", "v" },
            "<leader>Sa",
            require("nvim-emmet").wrap_with_abbreviation,
            { silent = true, desc = "Emmet wrap with abbreviation" }
        )
    end,
}
