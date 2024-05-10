return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        event = { "VeryLazy" },
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-media-files.nvim",
            "ThePrimeagen/harpoon"
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
                        -- "--no-ignore-vcs", -- Don't respect .gitignore
                        "--no-heading", -- Don't group matches by each file
                        "--with-filename", -- Print the file path with the matched lines
                        "--line-number", -- Show line numbers
                        "--column", -- Show column numbers
                        "--smart-case", -- Smart case search
                    },
                    file_ignore_patterns = {
                        "^.git//*",
                        "node_modules",
                        "build",
                        "^dist//*",
                        "yarn.lock",
                        "package-lock.json",
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    media_files = {
                        find_cmd = "rg",
                        filetypes = { "png", "svg", "webp", "jpg", "jpeg" },
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
            telescope.load_extension('harpoon')

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
            vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Find in files" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
            vim.keymap.set("n", "<leader>fm", ":Telescope harpoon marks<CR>", { desc = "Find harpoon marks" })
            vim.keymap.set("n", "<leader>fF", builtin.git_files, { desc = "Find git files" })
            vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Find git commits" })
            vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find git branches" })
        end,
    },
}
