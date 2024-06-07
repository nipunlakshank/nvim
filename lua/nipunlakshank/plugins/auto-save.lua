return {
    "Pocco81/auto-save.nvim",
    cmd = "ASToggle",
    config = function()
        local autosave = require("auto-save")
        autosave.setup({
            dim = 0.18,
            cleaning_interval = 1000,
            callbacks = { -- functions to be executed at different intervals
                enabling = nil, -- ran when enabling auto-save
                disabling = nil, -- ran when disabling auto-save

                -- FIX: this is not working
                before_asserting_save = function()
                    if vim.bo.filetype == "harpoon" then
                        return false
                    end
                end, -- ran before checking `condition`

                before_saving = nil, -- ran before doing the actual save
                after_saving = nil, -- ran after doing the actual save
            },
        })
        autosave.toggle()
    end,
}
