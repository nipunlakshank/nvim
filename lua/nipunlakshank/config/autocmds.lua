local vim_enter_group = vim.api.nvim_create_augroup("VimEnterGroup", {})
-- local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
local lsp_attach_group = vim.api.nvim_create_augroup("LspAttachGroup", {})
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
local python_env_group = vim.api.nvim_create_augroup("PythonEnvGroup", {})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim_enter_group,
    callback = function()
        vim.cmd.colorscheme(_G.colorscheme) -- Set colorscheme
    end,
})

-- auto-format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = lsp_fmt_group,
--     callback = function()
--         local efm = vim.lsp.get_active_clients({ name = "efm" })
--
--         if vim.tbl_isempty(efm) then
--             return
--         end
--
--         vim.lsp.buf.format({ name = "efm", async = true })
--     end,
-- })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = lsp_attach_group,
    pattern = { "*.dot" },
    callback = function()
        vim.lsp.start({
            name = "dot",
            cmd = { "dot-language-server", "--stdio" },
        })
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = python_env_group,
    callback = function()
        vim.schedule(function()
            local f = require("nipunlakshank.utils.functions")
            local python_env_path = vim.fn.stdpath("data") .. "/python"

            f.async_cmd("mkdir -p " .. python_env_path)
            f.async_cmd("python3 -m venv " .. python_env_path)
            f.async_cmd(
                "source "
                .. python_env_path
                .. "/bin/activate && pip install --upgrade pip && pip install neovim && deactivate"
            )
            vim.g.python3_host_prog = python_env_path .. "/bin/python3"
        end)
    end,
})
