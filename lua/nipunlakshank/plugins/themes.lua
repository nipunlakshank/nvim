local themes = {
    catppuccin = {
        "catppuccin/nvim",
        name = "catppuccin",

        -- init = function()
        --     local mini_indent_scope_hi_group = vim.api.nvim_create_augroup("MiniIndentScopeHighlightGroup", {})
        --     vim.api.nvim_create_autocmd({ "UIEnter", "Colorscheme" }, {
        --         group = mini_indent_scope_hi_group,
        --         pattern = "*",
        --         callback = function()
        --             local colorscheme = vim.g.colors_name
        --             if not string.match(colorscheme, "catppuccin") then
        --                 return
        --             end
        --             vim.schedule(function()
        --                 vim.cmd("highlight MiniIndentScopeSymbol guifg=#f5e0dd")
        --             end)
        --         end,
        --     })
        -- end,

        config = function()
            local opts = {
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true,
            }
            require("catppuccin").setup(opts)
        end,
    },
    onedarkpro = {
        "olimorris/onedarkpro.nvim",
        config = function()
            local opts = {
                options = {
                    transparency = true,
                },
            }
            require("onedarkpro").setup(opts)
        end,
    },

    tokyonight = {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            light_style = "day",
            transparent = true,
            terminal_colors = true,
        },
    },
}

local function get_themes(active_theme)
    local result = {}
    for name, theme in pairs(themes) do
        if active_theme == name then
            theme.event = theme.event or { "VimEnter" }
        else
            theme.event = theme.event or { "VeryLazy" }
        end
        table.insert(result, theme)
    end
    return result
end

-- Set active theme
local active_theme = _G.colorscheme

return get_themes(active_theme)
