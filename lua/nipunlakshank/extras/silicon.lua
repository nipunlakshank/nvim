return {
    "krivahtoo/silicon.nvim",
    cmd = "Silicon",
    build = "./install.sh build",
    config = function()
        local opts = {
            background = "#87f",
            font = "MesloLGS NF=26",
            theme = "Monokai Extended",
            line_number = true,
            pad_vert = 80,
            pad_horiz = 50,
            line_pad = 2,       -- (number) The padding between lines.
            -- line_offset = 1,    -- (number) The starting line number for the screenshot.
            tab_width = 4,      -- (number) The tab width for the screenshot.
            gobble = true,      -- (boolean) Whether to trim extra indentation.
            highlight_selection = false, -- (boolean) Whether to capture the whole file and highlight selected lines.
            round_corner = true,
            window_controls = true, -- (boolean) Whether to show window controls (minimize, maximize, close) in the screenshot.
            output = {
                file = "",
                path = vim.fn.expand("$HOME") .. "/dev/CodeSnapshots",
                format = "snapshot_[year][month][day]_[hour][minute][second].png",
            },
            watermark = {
                text = " @nipunlakshank",
            },
            window_title = function()
                return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
            end,
            shadow = {
                blur_radius = 10.0, -- (number) The blur radius for the shadow, set to 0.0 for no shadow.
                offset_x = 0, -- (number) The horizontal offset for the shadow.
                offset_y = 0, -- (number) The vertical offset for the shadow.
                color = "#555", -- (string) The color for the shadow.
            },
        }
        require("silicon").setup(opts)
    end,
}
