local themes = {
    catppuccin = {
        "catppuccin/nvim",
        name = "catppuccin",
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
        if name == active_theme then
            theme.priority = 1000
            theme.lazy = false
        end
        table.insert(result, theme)
    end
    return result
end

-- Set active theme
local active_theme = _G.colorscheme

return get_themes(active_theme)
