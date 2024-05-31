local themes = {
    catppuccin = {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "mocha",
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,
            color_overrides = {},
            highlight_overrides = {
                ---@diagnostic disable-next-line: unused-local
                all = function(colors)
                    return {
                        GitSignsCurrentLineBlame = { fg = "#8c8c8c" },
                    }
                end,
            },
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        },
    },
    onedarkpro = {
        "olimorris/onedarkpro.nvim",
        opts = {
            options = {
                transparency = true,
            },
        },
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
    ["rose-pine"] = {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "auto", -- auto, main, moon, or dawn
            dark_variant = "main", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true, -- Handle deprecated options automatically
            },

            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "rose",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "rose",
                git_untracked = "subtle",

                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },
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
