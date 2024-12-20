local get_opts = require("nipunlakshank.utils.keymap").get_opts
local default_opts = { buffer = true, silent = true }

-- execute lua
vim.keymap.set("v", "<leader>x", ":lua<CR>", get_opts("Execute selection (lua)", default_opts))
vim.keymap.set("n", "<leader>xx", "mxV:lua<cr>`x:delmarks x<cr>", get_opts("Execute current line (lua)", default_opts))
vim.keymap.set("n", "<leader>X", "mxggVG:lua<cr>`x:delmarks x<cr>", get_opts("Execute current buffer (lua)", default_opts))

