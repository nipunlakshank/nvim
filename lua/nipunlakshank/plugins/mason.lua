return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "BufReadPre",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				lazy = false,
				opts = {
					auto_install = true,
					ensure_installed = {
						"efm",
						"bashls",
						"tailwindcss",
						"pyright",
						"emmet_language_server",
						"jsonls",
						"lua_ls",
						"bashls",
						"tsserver",
						"intelephense",
					},
				},
			},
		},
	},
}
