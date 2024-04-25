local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Word wrap
opt.wrap = true
opt.textwidth=0
opt.wrapmargin=0
opt.linebreak = true -- (optional - breaks by word rather than character)
opt.columns=80 -- <<< THIS IS THE IMPORTANT PART

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "100"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"
opt.fillchars = { eob = " "}

-- Behaviour
vim.g.loaded_netrwPlugin = 0
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
-- opt.undodir = vim.fn.expand("~/.vim/undodir") -- Default is "$XDG_STATE_HOME/nvim/undo//"
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
-- opt.iskeyword:append("-")
opt.mouse = "a"
-- opt.clipboard:append("unnamedplus")
opt.modifiable = true
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.encoding = "UTF-8"
opt.showmode = false

-- folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

