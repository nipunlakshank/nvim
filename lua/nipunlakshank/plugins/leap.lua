return {
	"ggandor/leap.nvim",
	lazy = false,
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		local leap = require("leap")
        leap.setup({})
		vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward)")
		vim.keymap.set({ "n", "x", "o" }, "<leader>gs", "<Plug>(leap-from-window)")
	end,
}
