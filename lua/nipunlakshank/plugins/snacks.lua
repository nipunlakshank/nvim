---@diagnostic disable, 113: 113
return {
    "folke/snacks.nvim",
    dependencies = {
        { "https://gitlab.com/dwt1/shell-color-scripts", build = "sudo make install" },
    },
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",                  mode = { "n", "v" } },
        { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
        { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
        { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "Toggle Terminal",             mode = { "n", "t" } },
        { "]w",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
        { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                    border = "rounded",
                })
            end,
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command
                vim.ui.input = Snacks.input.input

                -- Create some toggle mappings
                -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<space><space>w")
                Snacks.toggle.diagnostics():map("<space><space>d")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<space><space>h")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,

    config = function()
        local dashboards = require("nipunlakshank.utils.dashboard").presets

        ---@module "snacks"
        ---@type snacks.Config
        local opts = {
            bigfile = { enabled = true },
            dashboard = dashboards.projects,
            indent = {
                indent = {
                    priority = 1,
                    enabled = true,       -- enable indent guides
                    char = "│",
                    only_scope = false,   -- only show indent guides of the scope
                    only_current = false, -- only show indent guides in the current window
                    hl = "IblIndent", ---@type string|string[] hl groups for indent guides
                },
                -- animate scopes. Enabled by default for Neovim >= 0.10
                -- Works on older versions but has to trigger redraws during animation.
                ---@class snacks.indent.animate: snacks.animate.Config
                animate = {
                    enabled = vim.fn.has("nvim-0.10") == 1,
                    style = "out",
                    easing = "linear",
                    duration = {
                        step = 20,   -- ms per step
                        total = 500, -- maximum duration
                    },
                },
                ---@class snacks.indent.Scope.Config: snacks.scope.Config
                scope = {
                    enabled = true, -- enable highlighting the current scope
                    priority = 200,
                    char = "│",
                    underline = false,    -- underline the start of the scope
                    only_current = false, -- only show scope in the current window
                    hl = "MiniIndentscopeSymbol", ---@type string|string[] hl group for scopes
                },
                chunk = {
                    -- when enabled, scopes will be rendered as chunks, except for the
                    -- top-level scope which will be rendered as a scope.
                    enabled = false,
                    -- only show chunk scopes in the current window
                    only_current = false,
                    priority = 200,
                    hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
                    char = {
                        -- corner_top = "┌",
                        -- corner_bottom = "└",
                        corner_top = "╭",
                        corner_bottom = "╰",
                        horizontal = "─",
                        vertical = "│",
                        arrow = ">",
                    },
                },
                blank = {
                    char = " ",
                    -- char = "·",
                    hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
                },
            },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
                filter = function(notif)
                    return not notif.msg:find('No information available')
                        and not notif.msg:find('man.lua: "no manual entry for ')
                end,
            },
            lazygit = { win = { border = "rounded" } },
            quickfile = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            scratch = {
                win = {
                    width = 100,
                    height = 30,
                    bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
                    minimal = false,
                    noautocmd = false,
                    -- position = "right",
                    zindex = 20,
                    wo = { winhighlight = "NormalFloat:Normal" },
                    border = "rounded",
                    title_pos = "center",
                    footer_pos = "center",
                },
            },
            image = {
                formats = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm" },
                force = false, -- try displaying the image, even if the terminal does not support it
                markdown = {
                    -- enable image viewer for markdown files
                    -- if your env doesn't support unicode placeholders, this will be disabled
                    enabled = true,
                    inline = true, -- render the image inline in the buffer (takes precedence over `opts.float` on supported terminals)
                    float = true,  -- render the image in a floating window
                    max_width = 80,
                    max_height = 40,
                },
                doc = {
                    inline = false,
                    float = true,
                },
                -- window options applied to windows displaying image buffers
                -- an image buffer is a buffer with `filetype=image`
                wo = {
                    wrap = false,
                    number = false,
                    relativenumber = false,
                    cursorcolumn = false,
                    signcolumn = "no",
                    foldcolumn = "0",
                    list = false,
                    spell = false,
                    statuscolumn = "",
                },
                env = {},
            },
        }

        require("snacks").setup(opts)
    end,
}
