return {
    "Pocco81/auto-save.nvim",
    cmd = "ASToggle",
    config = function()
        local autosave = require("auto-save")
        autosave.setup({
            dim = 0.18,
            cleaning_interval = 1000,
        })
        autosave.toggle()
    end,
}
