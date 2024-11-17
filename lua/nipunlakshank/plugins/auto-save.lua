return {
    "okuuva/auto-save.nvim",
    version = "*",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
        enabled = false, -- whether to enable autosave when the plugin is loaded
        debounce_delay = 1000, -- delay after which a pending save is executed
        trigger_events = { -- See :h events
            immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
            defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
            cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
        },
        condition = function(buf)
            local fn = vim.fn
            local utils = require("auto-save.utils.data")

            local disabled_filetypes = {
                "harpoon",
                "sql",
            }

            -- don't save for special-buffers
            if fn.getbufvar(buf, "&buftype") ~= "" then
                return false
            end

            if utils.not_in(fn.getbufvar(buf, "&filetype"), disabled_filetypes) then
                return true -- met condition(s), can save
            end

            return false -- can't save
        end,
        write_all_buffers = false, -- write all buffers when the current one meets `condition`
        noautocmd = false, -- do not execute autocmds when saving
        lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
        -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
        debug = false,
    },
}
