return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "BlakeJC94/alpha-nvim-fortune",
    },
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            return
        end

        local dashboard = require("alpha.themes.dashboard")
        local arts = require("nipunlakshank.utils.arts")

        dashboard.section.header.val = function()
            return arts.dragon
        end

        dashboard.section.buttons.val = {
            dashboard.button("t", "󰙅  File tree", ":Neotree filesystem toggle <CR>"),
            dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "󱋡  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("g", "󰺮  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/ <CR>"),
            dashboard.button("q", "󰗼  Quit Neovim", ":qa<CR>"),
        }

        local function footer()
            local fortune = require("alpha.fortune")()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local f = {
                "",
                "\t ⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }

            -- BUG: fortune is sometimes a table and sometimes a string
            if type(fortune) == "table" then
                for _, str in ipairs(fortune) do
                    table.insert(f, str)
                end
            else
                local sep = "\n"
                for str in string.gmatch(fortune, "([^" .. sep .. "]+)") do
                    table.insert(f, str)
                end
            end

            return f
        end

        vim.api.nvim_create_autocmd("UIEnter", {
            callback = function()
                dashboard.section.footer.val = footer()
            end,
        })

        dashboard.section.header.opts.hl = "Error"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.section.footer.opts.hl = "WarningMsg"

        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "DashboardLoaded",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        dashboard.opts.opts.noautocmd = false
        alpha.setup(dashboard.opts)
    end,
}
