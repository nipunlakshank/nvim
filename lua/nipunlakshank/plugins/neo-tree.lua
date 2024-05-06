return {
    "nvim-neo-tree/neo-tree.nvim",
    event = { "VeryLazy" },
    cmd = { "NeoTree" },
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        { "3rd/image.nvim", optional = true }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local opts = {
            filesystem = {
                filtered_items = {
                    visible = false,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        ".git",
                        ".DS_Store",
                        "thumbs.db",
                        "[dD]esktop.ini",
                        ".idea",
                        ".vscode",
                    },
                    never_show = {},
                },
            },
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
