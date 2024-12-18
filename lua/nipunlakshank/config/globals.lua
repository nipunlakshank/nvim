vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

_G.colorscheme = "catppuccin"

function string.endswith(str, pattern)
    local _, e, _ = string.find(str, pattern)
    return e == #str
end
