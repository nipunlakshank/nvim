function Feedkeys(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

vim.cmd.colorscheme(_G.colorscheme) -- Set colorscheme

-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_fmt_group,
    callback = function()
        local efm = vim.lsp.get_active_clients({ name = "efm" })

        if vim.tbl_isempty(efm) then
            return
        end

        vim.lsp.buf.format({ name = "efm", async = true })
    end,
})

-- highlight on yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

local vim_enter_group = vim.api.nvim_create_augroup("VimEnterGroup", {})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim_enter_group,
    callback = function()
        local file_info = vim.api.nvim_command_output("f")

        if string.find(file_info, "--No lines in buffer--") and not string.find(file_info, "%[New%]") then
            vim.cmd("Neotree")
            vim.cmd("wincmd l")
            vim.cmd("sleep 100m")
            vim.cmd("Alpha")
        end
    end,
})
