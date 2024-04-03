return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-media-files.nvim",
        },
        config = function()
            local telescope = require("telescope")

            local opts = {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    media_files = {
                        filetypes = { "png", "webp", "jpg", "jpeg" },
                        find_cmd = "rg",
                    },
                },
            }

            telescope.setup(opts)

            -- load extensions
            telescope.load_extension("ui-select")
            telescope.load_extension("media_files")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end,
    },
}
