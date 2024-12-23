local keymap = require("nipunlakshank.utils.keymap")
local mapper = keymap.mapper
local get_opts = keymap.get_opts

-- general
vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", get_opts("Clear search highlights"))
vim.keymap.set("n", "-", "<cmd>Oil<cr>", get_opts("Parent directory"))
vim.keymap.set("n", "<leader>o", 'o<esc>"_S', get_opts("New line below without comment"))
vim.keymap.set("n", "<leader>O", 'O<esc>"_S', get_opts("New line above without comment"))

-- move lines vertically
mapper
    .modes("n")
    .key({ "<M-j>", mac = "∆" })
    .action(":m .+1<cr>==")
    .opts(get_opts("Move line down"))
    .set()
mapper
    .modes("v")
    .key({ "<M-j>", mac = "∆" })
    .action(":m '>+1<cr>gv=gv")
    .opts(get_opts("Move selection down"))
    .set()
mapper
    .modes("n")
    .key({ "<M-k>", mac = "˚" })
    .action(":m .-2<cr>==")
    .opts(get_opts("Move line up"))
    .set()
mapper
    .modes("v")
    .key({ "<M-k>", mac = "˚" })
    .action(":m '<-2<cr>gv=gv")
    .opts(get_opts("Move selection up"))
    .set()

-- Indenting
vim.keymap.set("v", "<", "<gv", get_opts("Indent left"))
vim.keymap.set("v", ">", ">gv", get_opts("Indent right"))

-- Scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", get_opts("Scroll half page up"))
vim.keymap.set("n", "<C-d>", "<C-d>zz", get_opts("Scroll half page down"))

-- buffer navigation
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", get_opts("Alternate buffer"))
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", get_opts("Next buffer"))
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", get_opts("Previous buffer"))

-- yanking/pasting
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', get_opts("Yank to system clipboard"))
vim.keymap.set("n", "<leader>Y", function()
    vim.cmd([[normal my]])
    vim.cmd([[normal gg"+yG`y]])
    vim.cmd([[delmarks y]])
end, get_opts("Yank to system clipboard"))
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', get_opts("Paste from system clipboard"))

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", get_opts("Go to left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", get_opts("Go to above window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", get_opts("Go to below window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", get_opts("Go to right window"))
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", get_opts("Go to left window"))
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", get_opts("Go to above window"))
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", get_opts("Go to below window"))
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", get_opts("Go to right window"))

-- window splitting
vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", get_opts("Split window vertically"))
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", get_opts("Split window horizontally"))

-- resize windows
vim.keymap.set("n", "<A-Up>", "<cmd>horizontal resize +2<cr>", get_opts("Resize window up"))
vim.keymap.set("n", "<A-Down>", "<cmd>horizontal resize -2<cr>", get_opts("Resize window down"))
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", get_opts("Resize window left"))
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", get_opts("Resize window right"))

-- fzf-lua
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", get_opts("Find files"))
vim.keymap.set("n", "<leader>fF", "<cmd>FzfLua git_files<cr>", get_opts("Find git files"))
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", get_opts("Find recent files"))
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep_project<cr>", get_opts("Find text"))
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", get_opts("Find help"))
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", get_opts("Find buffers"))
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<cr>", get_opts("Find marks"))
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>", get_opts("Find colorschemes"))
vim.keymap.set("n", "<leader>fB", "<cmd>FzfLua git_branches<cr>", get_opts("Find git branches"))
vim.keymap.set("n", "<leader>fC", "<cmd>FzfLua git_commits<cr>", get_opts("Find git commits"))
vim.keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", get_opts("Find todo-comments"))
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua resume<cr>", get_opts("FzfLua last state"))
vim.keymap.set("n", "<leader>fp", "<cmd>FzfLua profiles<cr>", get_opts("Select FzfLua profile"))

-- formatting
vim.keymap.set("n", "<leader>lf", function()
    vim.cmd([[normal mf]])
    vim.cmd([[normal gg=G`f]])
    vim.cmd([[delmarks f]])
end, get_opts("Format buffer"))
vim.keymap.set("v", "<leader>lf", "=", get_opts("Format selection"))

-- toggle windows
vim.keymap.set("n", "<leader>wl", "<cmd>Lazy<cr>", get_opts("Open Lazy"))
vim.keymap.set("n", "<leader>wi", "<cmd>LspInfo<cr>", get_opts("Open LspInfo"))
vim.keymap.set("n", "<leader>wm", "<cmd>Mason<cr>", get_opts("Open Mason"))

-- open github short urls
vim.keymap.set("n", "<leader>gx", function()
    -- TODO: get short url under cursor, prepend 'https://github.com/', open it with system browser (vim.system("open " .. url))
end, get_opts("Open github url"))

-- colorizer
vim.keymap.set("n", "<leader>cl", "<cmd>ColorizerToggle<cr>", get_opts("Toggle Colorizer"))

-- autosave
vim.keymap.set("n", "<leader><leader>s", "<cmd>ASToggle<cr>", get_opts("Toggle auto-save"))

-- Snacks
vim.keymap.set("n", "<leader>cn", function()
    ---@module "snacks"
    ---@diagnostic disable-next-line: missing-fields
    Snacks.input.input({
        prompt = "New file",
        default = vim.fs.dirname(vim.fn.expand("%")) .. "/",
    }, function(value)
        if not value then
            return
        end
        local dir = vim.fs.dirname(value)
        local result = vim.system({ "mkdir", "-p", dir }):wait()
        if result.code == 1 and result.stderr then
            dd(result.stderr)
            bt()
        else
            vim.cmd({ cmd = "e", args = { value } })
        end
    end)
end)
