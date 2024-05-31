local mapkey = require("nipunlakshank.utils.keymapper").mapvimkey
local f = require("nipunlakshank.utils.functions")

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n")     -- Next buffer
mapkey("<leader>bp", "bprevious", "n") -- Prev buffer
mapkey("<leader>bb", "e #", "n")       -- Switch to Other Buffer

-- File Explorer
mapkey("<leader>ef", "Neotree", "n")
mapkey("<leader>et", "Neotree toggle", "n")

-- Pane and Window Navigation
mapkey("<C-h>", "<C-w>h", "n")            -- Navigate Left
mapkey("<C-j>", "<C-w>j", "n")            -- Navigate Down
mapkey("<C-k>", "<C-w>k", "n")            -- Navigate Up
mapkey("<C-l>", "<C-w>l", "n")            -- Navigate Right
mapkey("<C-h>", "wincmd h", "t")          -- Navigate Left
mapkey("<C-j>", "wincmd j", "t")          -- Navigate Down
mapkey("<C-k>", "wincmd k", "t")          -- Navigate Up
mapkey("<C-l>", "wincmd l", "t")          -- Navigate Right
mapkey("<C-h>", "TmuxNavigateLeft", "n")  -- Navigate Left
mapkey("<C-j>", "TmuxNavigateDown", "n")  -- Navigate Down
mapkey("<C-k>", "TmuxNavigateUp", "n")    -- Navigate Up
mapkey("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window Management
mapkey("<leader>%", "vsplit", "n", { desc = "Split window vertically" })
mapkey('<leader>"', "split", "n", { desc = "Split window horizontally" })
mapkey("<A-Up>", "horizontal resize +2", "n", { desc = "Resize window up" })
mapkey("<A-Down>", "horizontal resize -2", "n", { desc = "Resize window down" })
mapkey("<A-Left>", "vertical resize -2", "n", { desc = "Resize window left" })
mapkey("<A-Right>", "vertical resize +2", "n", { desc = "Resize window right" })

-- Toggle word wrapping
mapkey("<leader>tw", "set wrap!", "n", { desc = "Toggle word wrapping" })
mapkey("<leader>tw", "set wrap!", "v", { desc = "Toggle word wrapping" })

-- New tmux pane below (terminal)
vim.keymap.set("n", "<leader>`", function()
    local cwd = vim.loop.cwd()
    vim.cmd("silent !tmux splitw -vl 15 -c " .. cwd)
end, { silent = true, desc = "Create new tmux pane below" })

-- Show Full File-Path
vim.keymap.set(
    "n",
    "<leader>ap",
    "<Cmd>echo expand('%:p')<CR>",
    { noremap = true, silent = true, desc = "Show full file path" }
)
vim.keymap.set("n", "<leader>rp", "<Cmd>file<CR>", { noremap = true, silent = true, desc = "Show relative file path" })

if f.os.is_mac() then
    -- Move lines vertically (MacOS)
    vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" }) -- Option + j
    vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" }) -- Option + k
    vim.keymap.set("n", "∆", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" }) -- Option + j
    vim.keymap.set("n", "˚", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" }) -- Option + k
    vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" }) -- Option + j
    vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" }) -- Option + k
else
    -- Move lines vertically (Linux, Windows)
    vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
    vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })
    vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
    vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
    vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" })
    vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" })
end

-- Formatting
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })

-- Indenting
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })

-- Find and Replace
vim.keymap.set("n", "<leader>R", ":%s///g<left><left>", { silent = true, noremap = true, desc = "Replace in file" })
vim.keymap.set(
    "n",
    "<leader>Rc",
    ":%s///gc<left><left><left>",
    { silent = true, noremap = true, desc = "Replace in file" }
)
vim.keymap.set(
    "v",
    "<leader>R",
    ":s///g<left><left>",
    { silent = true, noremap = true, desc = "Replace in selected area" }
)
vim.keymap.set(
    "v",
    "<leader>Rc",
    ":s///gc<left><left><left>",
    { silent = true, noremap = true, desc = "Replace in selected area" }
)

-- Search
vim.keymap.set(
    { "n", "s" },
    "<Esc>",
    "<Cmd>nohlsearch<CR>",
    { noremap = true, silent = true, desc = "Clear search highlights" }
)

-- Backspace motions
vim.keymap.set("i", "<C-BS>", '<Esc>"_ddk$', { noremap = true, silent = true, desc = "Delete current line" })

-- Enter new lines without leaving normal mode
if f.os.is_mac() then
    vim.keymap.set("n", "ø", 'o<Esc>0"_D', { noremap = true, silent = true, desc = "Insert newline below (<A-o>)" })
    vim.keymap.set(
        "n",
        "Ø",
        'mzO<Esc>0"_D`z',
        { noremap = true, silent = true, desc = "Insert newline above (<A-O>)" }
    )
else
    vim.keymap.set("n", "<A-o>", 'o<Esc>0"_D', { noremap = true, silent = true, desc = "Insert newline below" })
    vim.keymap.set("n", "<A-O>", 'mzO<Esc>0"_D`z', { noremap = true, silent = true, desc = "Insert newline above" })
end

-- Usefull when jumping from a commented line to a new line
vim.keymap.set(
    "n",
    "<leader>o",
    'o<Esc>"_S',
    { noremap = true, silent = true, desc = "Insert newline below and clear before changing to insert mode" }
)
vim.keymap.set(
    "n",
    "<leader>O",
    'O<Esc>"_S',
    { noremap = true, silent = true, desc = "Insert newline above and clear before changing to insert mode" }
)

-- Copy, Paste and Delete
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank selection into system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { noremap = true, desc = "Yank to end of line to system clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { noremap = true, desc = "Yank line into system clipboard" })
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, desc = "Paste without yanking" })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, desc = "Delete into void" })

-- New lines and appending
vim.keymap.set("i", "<S-CR>", "<Esc>o", { noremap = true, silent = true, desc = "Insert a new line below" })
vim.keymap.set("i", "<C-CR>", "<Esc>jA", { noremap = true, silent = true, desc = "Append to line below" })

-- Diagnostics (Currently handled through Lspsaga)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic message"})
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic message"})
-- vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, {desc = "Show diagnostic message"})
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {desc = "Open diagnostics quickfix list"})

-- Lsp
vim.keymap.set("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { desc = "Show inlay hints" })
-- Noice
vim.keymap.set("n", "<leader>nc", "<Cmd>NoiceDismiss<CR>", { noremap = true, desc = "Clear Noice messages" })

-- Snapshots
vim.keymap.set("n", "<C-s>s", "<Cmd>Silicon!<CR>", { desc = "Take a snapshot of the current buffer" })
vim.keymap.set("v", "<C-s>s", "<Cmd>Silicon!<CR>", { desc = "Take a snapshot of the current selection" })
vim.keymap.set("n", "<C-s>c", "<Cmd>Silicon<CR>", { desc = "Take a snapshot of the current buffer into clipboard" })
vim.keymap.set("v", "<leader>Sc", "<Cmd>Silicon<CR>", { desc = "Take a snapshot of the current selection into clipboard" })

-- Auto save
vim.keymap.set("n", "<leader>as", "<Cmd>ASToggle<CR>", { desc = "Toggle auto save" })

-- Live Server
-- vim.keymap.set("n", "<leader>lss", "<Cmd>LiveServerStart<CR>", { desc = "Start live server" })
-- vim.keymap.set("n", "<leader>lsx", "<Cmd>LiveServerStop<CR>", { desc = "Stop live server" })

-- Vim Tests
vim.keymap.set("n", "<leader>tn", "<Cmd>TestNearest<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", "<Cmd>TestFile<CR>", { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>tc", "<Cmd>TestClass<CR>", { desc = "Run all tests in class" })
vim.keymap.set("n", "<leader>ts", "<Cmd>TestSuite<CR>", { desc = "Run all tests in suite" })
vim.keymap.set("n", "<leader>tl", "<Cmd>TestLast<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>tv", "<Cmd>TestVisit<CR>", { desc = "Visit test file" })

-- Plenary tests
vim.keymap.set("n", "<leader>pd", function()
    require("plenary.test_harness").test_directory(vim.loop.cwd(), {})
end, { desc = "Run tests in directory" })
vim.keymap.set("n", "<leader>pf", function()
    require("plenary.test_harness").test_file(vim.fn.expand("%"))
end, { desc = "Run tests in file" })

-- Undo tree
vim.keymap.set("n", "<leader>ut", function()
    require("undotree").toggle()
end, { noremap = true, silent = true, desc = "Toggle undo tree" })

-- DBUI
vim.keymap.set("n", "<leader>DB", "<Cmd>DBUIToggle<CR>", { desc = "Toggle DBUI" })

-- Oil (File Explorer)
vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory in oil" })

-- Colorizer
vim.keymap.set("n", "<leader>cl", "<Cmd>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
vim.keymap.set("n", "<leader>cL", "<Cmd>ColorizerReloadAllBuffers<CR>", { desc = "Reload Colorizer" })

-- TODO Comments
vim.keymap.set("n", "<leader>ft", "<Cmd>TodoTelescope<CR>", { desc = "Find TODO comments" })

-- Opening windows
vim.keymap.set("n", "<leader>wl", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
vim.keymap.set("n", "<leader>wm", "<Cmd>Mason<CR>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>wi", "<Cmd>LspInfo<CR>", { desc = "Open LspInfo" })

-- Cloak
vim.keymap.set("n", "<leader>ct", "<Cmd>CloakPreviewLine<CR>", { desc = "Preview cloaked value in current line" })
vim.keymap.set("n", "<leader>cT", "<Cmd>CloakToggle<CR>", { desc = "Toggle cloak in current file" })

-- Compiler
-- Open compiler
vim.api.nvim_set_keymap('n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
-- Redo last selected option
vim.api.nvim_set_keymap('n', '<S-F6>', "<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<cr>", { noremap = true, silent = true })
-- Toggle compiler results
vim.api.nvim_set_keymap('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- Neogit
vim.keymap.set("n", "<leader>G", "<Cmd>Neogit<CR>", { desc = "Open Neogit" })
