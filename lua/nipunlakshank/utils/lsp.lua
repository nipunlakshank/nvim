local mapkey = require("nipunlakshank.utils.keymapper").mapvimkey

local M = {}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	mapkey("<leader>gr", "Lspsaga finder", "n", opts) -- go to definition
	mapkey("<leader>gp", "Lspsaga peek_definition", "n", opts) -- peak definition
	mapkey("<leader>gd", "Lspsaga goto_definition", "n", opts) -- go to definition
	mapkey("<leader>gh", "split | Lspsaga goto_definition", "n", opts) -- open definition in a horizontal split pane
	mapkey("<leader>gv", "vsplit | Lspsaga goto_definition", "n", opts) -- open definition in a vertical split pane
	mapkey("<leader>ca", "Lspsaga code_action", "n", opts) -- see available code actions
	mapkey("<leader>rn", "Lspsaga rename", "n", opts) -- smart rename
	mapkey("<leader>bd", "Lspsaga show_buf_diagnostics", "n", opts) -- show  diagnostics for buffer
	mapkey("<leader>ld", "Lspsaga show_line_diagnostics", "n", opts) -- show  diagnostics for line
	mapkey("<leader>cd", "Lspsaga show_cursor_diagnostics", "n", opts) -- show diagnostics for cursor
	mapkey("[d", "Lspsaga diagnostic_jump_prev", "n", opts) -- jump to prev diagnostic in buffer
	mapkey("]d", "Lspsaga diagnostic_jump_next", "n", opts) -- jump to next diagnostic in buffer
	mapkey("K", "Lspsaga hover_doc", "n", opts) -- show documentation for what is under cursor

	if client.name == "pyright" then
		mapkey("<leader>oi", "PyrightOrganizeImports", "n", opts) -- organise imports
		mapkey("<leader>db", "DapToggleBreakpoint", "n", opts) -- toggle breakpoint
		mapkey("<leader>dr", "DapContinue", "n", opts) -- continue/invoke debugger
		mapkey("<leader>dt", "lua require('dap-python').test_method()", "n", opts) -- run tests
	end

	if client.name == "ts_ls" then
		mapkey("<leader>oi", "TypeScriptOrganizeImports", "n", opts) -- organise imports
	end
end

M.typescript_organise_imports = {
	description = "Organise Imports",
	function()
		local params = {
			command = "_typescript.organizeImports",
			arguments = { vim.fn.expand("%:p") },
		}
		-- reorganise imports
		vim.lsp.buf.execute_command(params)
	end,
}

return M
