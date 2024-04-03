local mapkey = require("nipunlakshank.util.keymapper").mapvimkey

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n")     -- Next buffer
mapkey("<leader>bp", "bprevious", "n") -- Prev buffer
mapkey("<leader>bb", "e #", "n")       -- Switch to Other Buffer
mapkey("<leader>`", "e #", "n")        -- Switch to Other Buffer

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
mapkey("<leader>sv", "vsplit", "n") -- Split Vertically
mapkey("<leader>sh", "split", "n")  -- Split Horizontally
mapkey("<A-Up>", "horizontal resize +2", "n")
mapkey("<A-Down>", "horizontal resize -2", "n")
mapkey("<A-Left>", "vertical resize +2", "n")
mapkey("<A-Right>", "vertical resize -2", "n")

-- Show Full File-Path
mapkey("<leader>pa", "echo expand('%:p')", "n") -- Show Full File Path

-- Toggle word wrapping
mapkey("<C-w>", "set wrap!", "n")
mapkey("<C-w>", "set wrap!", "v")
mapkey("<C-w>", "set wrap!", "i")

if vim.fn.has("macunix") then
    -- Move lines vertically (MacOs)
    vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })    -- Option + j
    vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })      -- Option + k
    vim.keymap.set("n", "∆", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })        -- Option + j
    vim.keymap.set("n", "˚", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })          -- Option + k
    vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" }) -- Option + j
    vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" })   -- Option + k
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
vim.keymap.set("n", "<leader>r", ":%s///g<left><left>", { silent = true, noremap = true, desc = "Replace in file" })
vim.keymap.set( "n", "<leader>rc", ":%s///gc<left><left><left>", { silent = true, noremap = true, desc = "Replace in file" })
vim.keymap.set( "v", "<leader>r", ":s///g<left><left>", { silent = true, noremap = true, desc = "Replace in selected area" })
vim.keymap.set( "v", "<leader>rc", ":s///gc<left><left><left>", { silent = true, noremap = true, desc = "Replace in selected area" })

-- Copy, Paste and Delete
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, desc = "Paste without yanking" })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank selection into system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = true, desc = "Yank line into system clipboard" })

-- Noice
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice messages" })

-- Dashboard
vim.keymap.set("n", "<C-d>", ":Alpha<CR>", {})

-- Comments
vim.keymap.set("n", "<C-_>", "gtc", { noremap = false })
vim.keymap.set("v", "<C-_>", "goc", { noremap = false })

-- Snapshots
vim.keymap.set("n", "<leader>Ss", ":Silicon!<CR>", {})
vim.keymap.set("v", "<leader>Ss", ":Silicon!<CR>", {})
vim.keymap.set("v", "<leader>Sc", ":Silicon<CR>", {})
vim.keymap.set("n", "<leader>Sc", ":Silicon<CR>", {})

-- Auto save
vim.keymap.set("n", "<leader>as", ":ASToggle<CR>", {})

-- Live Server
vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", {})
vim.keymap.set("n", "<leader>lx", ":LiveServerStop<CR>", {})

-- Vim Tests
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", {})
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", {})
vim.keymap.set("n", "<leader>tc", ":TestClass<CR>", {})
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", {})
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", {})

-- Undo tree
vim.keymap.set('n', '<leader>ut', require('undotree').toggle, { noremap = true, silent = true })

