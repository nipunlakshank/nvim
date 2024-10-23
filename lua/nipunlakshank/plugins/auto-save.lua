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

                condition = function(buf)

                    if vim.bo.filetype == "harpoon" then
                        return false
                    end

                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true -- met condition(s), can save
                    end
                    return false -- can't save
                end,

                before_saving = nil, -- ran before doing the actual save
                after_saving = nil, -- ran after doing the actual save
            },
        })
        autosave.toggle()
    end,
}
