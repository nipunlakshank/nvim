local vim_enter_group = vim.api.nvim_create_augroup("VimEnterGroup", {})
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim_enter_group,
    callback = function()
        vim.cmd.colorscheme(_G.colorscheme) -- Set colorscheme
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim_enter_group,
    callback = function()
        vim.cmd([[silent exec "!kill -s SIGWINCH $PPID"]])
    end,
})

-- auto-format on save
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
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})
