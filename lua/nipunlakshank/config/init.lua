require("nipunlakshank.config.paths")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = "nipunlakshank.plugins"

local opts = {
	defaults = {
		lazy = true,
	},
    ui = {
        border = "rounded",
    },
	install = {
		colorscheme = { "onedarkpro" },
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrw",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
	change_detection = {
		notify = false,
	},
}

require("nipunlakshank.utils.functions")
require("nipunlakshank.config.globals")
require("nipunlakshank.config.options")

require("lazy").setup(plugins, opts)

require("nipunlakshank.config.keymaps")
require("nipunlakshank.config.autocmds")

