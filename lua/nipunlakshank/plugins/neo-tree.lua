return {
    "nvim-neo-tree/neo-tree.nvim",
    event = "BufWinEnter",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local opts = {
            source_selector = {
                winbar = true,
                statusline = false,
            },
            window = {
                mappings = {
                    ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                },
            },
            view = {
                adaptive_size = true,
            },
        }
        require("neo-tree").setup(opts)
    end,
}
