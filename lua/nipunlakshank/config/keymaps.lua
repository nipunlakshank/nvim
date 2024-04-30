local mapkey = require("nipunlakshank.utils.keymapper").mapvimkey

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n")     -- Next buffer
mapkey("<leader>bp", "bprevious", "n") -- Prev buffer
mapkey("<leader>bb", "e #", "n")       -- Switch to Other Buffer
mapkey("<leader>`", "e #", "n")        -- SWitch to Other Buffer

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
mapkey("<leader>%", "vsplit", "n") -- Split Vertically
mapkey("<leader>\"", "split", "n")  -- Split Horizontally
mapkey("<A-Up>", "horizontal resize +2", "n")
mapkey("<A-Down>", "horizontal resize -2", "n")
mapkey("<A-Left>", "vertical resize +2", "n")
mapkey("<A-Right>", "vertical resize -2", "n")

-- Toggle word wrapping
mapkey("<C-w>", "set wrap!", "n")
mapkey("<C-w>", "set wrap!", "v")
mapkey("<C-w>", "set wrap!", "i")

-- Show Full File-Path
vim.keymap.set("n", "<leader>pa", "<Cmd>echo expand('%:p')<CR>", { noremap = true, silent = true, desc = "Show full file path" })
vim.keymap.set("n", "<leader>pr", "<Cmd>file<CR>", { noremap = true, silent = true, desc = "Show relative file path" })

if vim.fn.has("macunix") then
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

-- Copy, Paste and Delete
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, desc = "Paste without yanking" })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank selection into system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = true, desc = "Yank line into system clipboard" })

-- Noice
vim.keymap.set("n", "<leader>nc", "<Cmd>NoiceDismiss<CR>", { noremap = true, desc = "Clear Noice messages" })

-- Dashboard
vim.keymap.set("n", "<C-d>", "<Cmd>Alpha<CR>", {})

-- Snapshots
vim.keymap.set("n", "<leader>Ss", "<Cmd>Silicon!<CR>", { desc = "Take a snapshot of the current buffer" })
vim.keymap.set("v", "<leader>Ss", "<Cmd>Silicon!<CR>", { desc = "Take a snapshot of the current selection" })
vim.keymap.set("n", "<leader>Sc", "<Cmd>Silicon<CR>", { desc = "Take a snapshot of the current buffer into clipboard" })
vim.keymap.set("v", "<leader>Sc", "<Cmd>Silicon<CR>", { desc = "Take a snapshot of the current selection into clipboard" })

-- Auto save
vim.keymap.set("n", "<leader>as", "<Cmd>ASToggle<CR>", { desc = "Toggle auto save" })

-- Live Server
vim.keymap.set("n", "<leader>lss", "<Cmd>LiveServerStart<CR>", { desc = "Start live server" })
vim.keymap.set("n", "<leader>lsx", "<Cmd>LiveServerStop<CR>", { desc = "Stop live server" })

-- Vim Tests
vim.keymap.set("n", "<leader>tn", "<Cmd>TestNearest<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", "<Cmd>TestFile<CR>", { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>tc", "<Cmd>TestClass<CR>", { desc = "Run all tests in class"})
vim.keymap.set("n", "<leader>ts", "<Cmd>TestSuite<CR>", { desc = "Run all tests in suite" })
vim.keymap.set("n", "<leader>tl", "<Cmd>TestLast<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>tv", "<Cmd>TestVisit<CR>", { desc = "Visit test file" })

-- Undo tree
vim.keymap.set("n", "<leader>ut", require("undotree").toggle, { noremap = true, silent = true, desc = "Toggle undo tree" })

-- Markdown preview
vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", { desc = "Preview markdown" })

-- DBUI
vim.keymap.set("n", "<leader>db", "<Cmd>DBUIToggle<CR>", { desc = "Toggle DBUI" })
