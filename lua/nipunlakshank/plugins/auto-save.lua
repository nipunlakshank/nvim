return {
    "Pocco81/auto-save.nvim",
    cmd = "ASToggle",
    config = function()
        require("auto-save").setup({
            dim = 0.18,
            cleaning_interval = 1000,
        })
    end,
}
