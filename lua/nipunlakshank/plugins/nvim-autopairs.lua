return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local opts = {}
        require("nvim-autopairs").setup(opts)
    end,
}
