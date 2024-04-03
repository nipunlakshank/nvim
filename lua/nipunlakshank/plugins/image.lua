return {
    "3rd/image.nvim",
    config = function()
        require("image").setup {
            backend = "ueberzug",
        }
    end,
}
