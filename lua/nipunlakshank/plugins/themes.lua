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
    ["rose-pine"] = {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
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

                highlight_groups = {
                    -- Comment = { fg = "foam" },
                    -- VertSplit = { fg = "muted", bg = "muted" },
                },

                before_highlight = function(group, highlight, palette)
                    -- Disable all undercurls
                    -- if highlight.undercurl then
                    --     highlight.undercurl = false
                    -- end
                    --
                    -- Change palette colour
                    -- if highlight.fg == palette.pine then
                    --     highlight.fg = palette.foam
                    -- end
                end,
            })

            -- vim.cmd("colorscheme rose-pine-main")
            -- vim.cmd("colorscheme rose-pine-moon")
            -- vim.cmd("colorscheme rose-pine-dawn")
        end,
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
