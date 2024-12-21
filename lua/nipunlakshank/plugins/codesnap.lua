local codesnap_save_location = "~/dev/CodeSnapshots"
local is_windows = vim.fn.has("win32") == 1

---@class codesnap.opts
---@field bg_theme "default"|"bamboo"|"sea"|"peach"|"grape"|"dusk"|"summer"

local opts = {
    mac_window_bar = true,                          -- (Optional) MacOS style title bar switch
    opacity = true,                                 -- (Optional) The code snap has some opacity by default, set it to false for 100% opacity
    watermark = "",                                 -- (Optional) you can custom your own watermark, but if you don't like it, just set it to ""
    preview_title = vim.fn.expand("%"),             -- (Optional) preview page title
    editor_font_family = "CaskaydiaCove Nerd Font", -- (Optional) preview code font family
    -- watermark_font_family = "Pacifico",             -- (Optional) watermark font family
}

if not is_windows then
    ---@type codesnap.opts
    opts = {
        save_path = codesnap_save_location,
        mac_window_bar = true,
        title = " nipunlakshank",
        code_font_family = "CaskaydiaCove Nerd Font",
        watermark_font_family = "CaskaydiaCove Nerd Font",
        watermark = " nipunlakshank",
        bg_theme = "default",
        breadcrumbs_separator = " » ",
        has_breadcrumbs = true,
        has_line_number = true,
        show_workspace = true,
        min_width = 0,
        bg_x_padding = 80,
        bg_y_padding = 40,
    }
end

local keys = is_windows and
    {
        { "<leader>cc", "<cmd>CodeSnap<cr>",                                 mode = "v", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cc", "mcggVG<cmd>CodeSnap<cr><esc>`c<cmd>delmarks c<cr>", mode = "n", desc = "Save buffer snapshot into clipboard" },
    }
    or
    {
        { "<leader>cc", "mcggVG<cmd>CodeSnap<cr><esc>`c<cmd>delmarks c<cr>",     mode = "n", desc = "Save buffer snapshot into clipboard" },
        { "<leader>cs", "mcggVG<cmd>CodeSnapSave<cr><esc>`c<cmd>delmarks c<cr>", mode = "n", desc = "Save buffer snapshot in " .. codesnap_save_location },
        { "<leader>cc", "<cmd>CodeSnap<cr>",                                     mode = "v", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", "<cmd>CodeSnapSave<cr>",                                 mode = "v", desc = "Save selected code snapshot in " .. codesnap_save_location },
    }


return {
    "mistricky/codesnap.nvim",
    version = is_windows and "0.0.11" or "*",
    pin = is_windows,
    build = "make",
    cmd = is_windows and { "CodeSnap", "CodeSnapPreviewOn" } or
        { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    keys = keys,
    opts = opts,
    --[[ config = function()
        vim.keymap.set({ "n" }, "<leader>cc", "mcggVG<cmd>CodeSnap<cr><esc>`c<cmd>delmarks c<cr>",
            { silent = true, noremap = true, desc = "Save buffer snapshot into clipboard" })

        vim.keymap.set({ "x" }, "<leader>cc", "<cmd>CodeSnap<cr>",
            { silent = true, noremap = true, desc = "Save selected code snapshot into clipboard" })

        if not is_windows then
            vim.keymap.set({ "n" }, "<leader>cs", "mcggVG<cmd>CodeSnapSave<cr><esc>`c<cmd>delmarks c<cr>",
                { silent = true, noremap = true, desc = "Save buffer snapshot in " .. codesnap_save_location })

            vim.keymap.set({ "x" }, "<leader>cs", "<cmd>CodeSnapSave<cr>",
                { silent = true, noremap = true, desc = "Save selected code snapshot in " .. codesnap_save_location })
        end

        require("codesnap").setup(opts)
    end, ]]
}
