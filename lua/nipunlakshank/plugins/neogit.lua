return {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("neogit").setup({})
    end,
}