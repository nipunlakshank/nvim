return {
    {
        "nvim-telescope/telescope.nvim",
        -- event = { "VeryLazy" },
        cmd = { "Telescope" },
        keys = {
            {
                "<leader>ff",
                "<leader>fr",
                "<leader>fl",
                "<leader>fb",
                "<leader>fh",
                "<leader>fF",
                "<leader>fgc",
                "<leader>fgb",
            },
        },
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
                    vimgrep_arguments = {
                        "rg",
                        "--follow", -- Follow symbolic links
                        "--hidden", -- Search for hidden files
                        "--no-heading", -- Don't group matches by each file
                        "--with-filename", -- Print the file path with the matched lines
                        "--line-number", -- Show line numbers
                        "--column", -- Show column numbers
                        "--smart-case", -- Smart case search
                    },
                    file_ignore_patterns = {
                        ".git",
                        ".idea",
                        ".vscode",
                        "package-lock.json",
                        "vendor",
                        "node_modules",
                        "build",
                        "dist",
                        "yarn.lock",
                        "package-lock.json",
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

                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            }

            telescope.setup(opts)

            -- load extensions
            telescope.load_extension("ui-select")
            telescope.load_extension("media_files")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
            vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Find in files" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
            vim.keymap.set("n", "<leader>fF", builtin.git_files, { desc = "Find git files" })
            vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Find git commits" })
            vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find git branches" })
        end,
    },
}
