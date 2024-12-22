local autocmd = vim.api.nvim_create_autocmd

local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
local python_env_group = vim.api.nvim_create_augroup("PythonEnvGroup", {})
local colorscheme_group = vim.api.nvim_create_augroup("ColorSchemeGroup", {})
local ft_group = vim.api.nvim_create_augroup("FileTypeGroup", {})
local group = vim.api.nvim_create_augroup("autosave", {})

vim.api.nvim_create_autocmd("User", {
    pattern = "AutoSaveWritePost",
    group = group,
    callback = function(opts)
        if opts.data.saved_buffer ~= nil then
            local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
            local rel_path = string.gsub(filename, vim.uv.cwd() and vim.uv.cwd() .. "/" or "", "")
            print("AutoSave: saved " .. rel_path .. " at " .. vim.fn.strftime("%H:%M:%S"))
        end
    end,
})

-- highlight on yank
autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

autocmd("VimEnter", {
    group = colorscheme_group,
    callback = function()
        vim.cmd.colorscheme "catppuccin"
        -- vim.cmd.colorscheme(_G.colorscheme) -- Set colorscheme
    end,
})

autocmd({ "UIEnter", "ColorScheme" }, {
    group = colorscheme_group,
    callback = function()
        local colorscheme = vim.g.colors_name
        local keymap = "<leader>tt"

        if string.match(colorscheme, "catppuccin") ~= -1 then
            vim.keymap.set("n", keymap, function()
                local catppuccin = require("catppuccin")
                local opts = catppuccin.options or {}
                opts.transparent_background = not opts.transparent_background
                catppuccin.compile()
                vim.cmd.colorscheme(vim.g.colors_name)
            end, {
                noremap = false,
                silent = true,
                desc = "Toggle transparency (" .. colorscheme .. ")",
            })
            return
        end
    end,
})

-- autocmd({ "VimEnter" }, {
--     group = python_env_group,
--     callback = function()
--         vim.schedule(function()
--             local f = require("nipunlakshank.utils.functions")
--             local python_env_path = vim.fn.stdpath("data") .. "/python"
--             local stat = vim.uv.fs_stat(python_env_path)
--             if not (stat and stat.type == "directory") then
--                 local success, err, _ = vim.uv.fs_mkdir(python_env_path, 493) -- 493 is 755 in octal
--                 if not success then
--                     vim.print("Failed to create python env directory: " .. err)
--                     return
--                 end
--             end
--
--             if vim.fn.has("win32") == 1 then
--                 f.async_cmd(
--                     "python -m venv "
--                         .. python_env_path
--                         .. ";  "
--                         .. python_env_path
--                         .. "/Scripts/activate && pip install --upgrade pip && pip install neovim; deactivate"
--                 )
--                 vim.g.python3_host_prog = python_env_path .. "/Scripts/python"
--             else
--                 f.async_cmd(
--                     "mkdir -p "
--                         .. python_env_path
--                         .. " && python3 -m venv "
--                         .. python_env_path
--                         .. " && source "
--                         .. python_env_path
--                         .. "/bin/activate && pip install --upgrade pip && pip install neovim && deactivate"
--                 )
--                 vim.g.python3_host_prog = python_env_path .. "/bin/python3"
--             end
--         end)
--     end,
-- })

autocmd({ "FileType" }, {
    group = ft_group,
    pattern = { "fugitive" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })
    end,
})
