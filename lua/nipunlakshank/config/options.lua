local opt = vim.opt

-- General
opt.confirm = true
opt.encoding = "UTF-8"
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("$XDG_STATE_HOME/nvim/undo//")
opt.undofile = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.smoothscroll = true
opt.hidden = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.modifiable = true
opt.showmode = false
opt.completeopt = { "menu", "menuone", "noinsert" }
opt.updatetime = 200
opt.laststatus = 3
-- opt.iskeyword:append("-")
-- opt.clipboard:append("unnamedplus")

-- Tab / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true

-- Word wrap
opt.wrap = true
opt.textwidth = 0
opt.wrapmargin = 0
opt.linebreak = true -- (optional - breaks by word rather than character)

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.guifont = "Jetbrains Mono:h16"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.cmdheight = 1
opt.scrolloff = 10
opt.fillchars = { eob = " " }
opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
