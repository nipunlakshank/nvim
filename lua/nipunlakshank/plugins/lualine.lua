---@diagnostic disable: unused-local, unused-function
return {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        local space = { '%s', color = { bg = "" } }
        local sep_left = { left = '' }
        local sep_right = { right = '' }
        local capsule = { left = '', right = '' }

        -- TODO: replace git status with this function
        -- this should check if the diff value is 0 or not and then include it or not
        local diff = function()
            local added = vim.b.gitsigns_status_dict.added
            local icon = ''
            local color = { fg = '#a6e3a1' }

            return {}, {}, {}
        end

        lualine.setup({
            options = {
                -- theme = bubbles_theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = { { 'mode', separator = capsule --[[ , right_padding = 0 ]] } },
                lualine_b = {
                    space,
                    { 'vim.b.gitsigns_head', icon = '', color = { fg = '#fab387', bg = '#313244' }, separator = capsule },
                    space,
                    { 'filename', separator = capsule },
                    { 'vim.b.gitsigns_status_dict.added', icon = '', color = { fg = '#a6e3a1' } },
                    { 'vim.b.gitsigns_status_dict.changed', icon = '', color = { fg = '#f9e2af' } },
                    { 'vim.b.gitsigns_status_dict.removed', icon = '', color = { fg = '#f38ba8' } },
                },
                lualine_c = {
                    '%=',
                    --[[ add your center compoentnts here in place of this comment ]]
                    -- { 'buffers' },
                    '%=',
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        })
    end,
}
