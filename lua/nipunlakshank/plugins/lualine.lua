return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"tpope/vim-fugitive",
	},
	event = { "VeryLazy" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = auto,
				global_status = true,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "diff" },
				lualine_c = { "%=", "buffers" },
				lualine_x = { { "FugitiveHead", icon = { "", color = { fg = "Orange" } } } },
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = { "progress", "location" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
		})
	end,
}
