return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("Comment").setup({
			pre_hook = function()
				return vim.bo.commentstring
			end,
		})
	end,
}
