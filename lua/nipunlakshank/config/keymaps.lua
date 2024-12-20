local keymap = require("nipunlakshank.utils.keymap")
local mapper = keymap.mapper
local get_opts = keymap.get_opts

-- general
vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", get_opts("Clear search highlights"))
vim.keymap.set("n", "-", "<cmd>Oil<cr>", get_opts("Parent directory"))

-- yanking
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", get_opts("Yank to system clipboard"))
vim.keymap.set("n", "<leader>Y", function() 
    vim.cmd [[normal my]]
    vim.cmd [[normal gg"+yG`y]]
    vim.cmd [[delmarks y]]
end, get_opts("Yank to system clipboard"))

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", get_opts("Go to left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", get_opts("Go to above window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", get_opts("Go to below window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", get_opts("Go to right window"))

-- window splitting
vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", get_opts("Split window vertically"))
vim.keymap.set("n", "<leader>\"", "<cmd>split<cr>", get_opts("Split window horizontally"))

-- resize windows
vim.keymap.set("n", "<A-Up>", "<cmd>horizontal resize +2<cr>", get_opts("Resize window up"))
vim.keymap.set("n", "<A-Down>", "<cmd>horizontal resize -2<cr>", get_opts("Resize window down"))
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", get_opts("Resize window left"))
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", get_opts("Resize window right"))

-- fzf-lua
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", get_opts("Find files"))
vim.keymap.set("n", "<leader>fF", "<cmd>FzfLua git_files<cr>", get_opts("Find git files"))
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", get_opts("Find recent files"))
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", get_opts("Find text"))
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", get_opts("Find help"))
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", get_opts("Find buffers"))
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<cr>", get_opts("Find marks"))
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>", get_opts("Find colorschemes"))
vim.keymap.set("n", "<leader>fB", "<cmd>FzfLua git_branches<cr>", get_opts("Find git branches"))
vim.keymap.set("n", "<leader>fC", "<cmd>FzfLua git_commits<cr>", get_opts("Find git commits"))
vim.keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", get_opts("Find todo-comments"))

-- formatting
vim.keymap.set("n", "<leader>lf", function() 
    vim.cmd [[normal mf]]
    vim.cmd [[normal gg=G`f]]
    vim.cmd [[delmarks f]]
end, get_opts("Format buffer"))
vim.keymap.set("v", "<leader>lf", "=", get_opts("Format selection"))

-- open github short urls
vim.keymap.set("n", "<leader>gx", function()
    -- TODO: get short url under cursor, prepend 'https://github.com/', open it with system browser (vim.system("open " .. url))
end, get_opts("Open github url"))

-- colorizer
vim.keymap.set("n", "<leader>cl", "<cmd>ColorizerToggle<cr>", get_opts("Toggle Colorizer"))

-- autosave
vim.keymap.set("n", "<leader>ts", "<cmd>ASToggle<cr>", get_opts("Toggle auto-save"))
