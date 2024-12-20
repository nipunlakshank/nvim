local keymap = require("nipunlakshank.utils.keymap")
local mapper = keymap.mapper
local get_opts = keymap.get_opts

-- general
vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", get_opts("Clear search highlights"))
vim.keymap.set("n", "-", ":Ex<CR>", get_opts("Parent directory"))

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", get_opts("Go to left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", get_opts("Go to above window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", get_opts("Go to below window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", get_opts("Go to right window"))

-- window splitting
vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", get_opts("Split window vertically"))
vim.keymap.set("n", "<leader>\"", "<cmd>split<cr>", get_opts("Split window horizontally"))

-- resize windows
vim.keymap.set("n", "<A-Up>", "horizontal resize +2", get_opts("Resize window up"))
vim.keymap.set("n", "<A-Down>", "horizontal resize -2", get_opts("Resize window down"))
vim.keymap.set("n", "<A-Left>", "vertical resize -2", get_opts("Resize window left"))
vim.keymap.set("n", "<A-Right>", "vertical resize +2", get_opts("Resize window right"))

-- fzf-lua
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", get_opts("Find files"))
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", get_opts("Find recent files"))
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua livegrep<cr>", get_opts("Find text"))
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", get_opts("Find help"))
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", get_opts("Find buffers"))
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<cr>", get_opts("Find marks"))
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>", get_opts("Find colorschemes"))

