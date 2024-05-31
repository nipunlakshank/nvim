return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
    },
    cmd = { "Spectre" },
    config = function()
        local opts = {
            open_cmd = "vnew",
        }
        require("spectre").setup(opts)
    end,
}
