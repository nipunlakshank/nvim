local autocmd = vim.api.nvim_create_autocmd

local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
local python_env_group = vim.api.nvim_create_augroup("PythonEnvGroup", {})
local colorscheme_group = vim.api.nvim_create_augroup("ColorSchemeGroup", {})
local ft_group = vim.api.nvim_create_augroup("FileTypeGroup", {})
local autosave_group = vim.api.nvim_create_augroup("autosave", { clear = true })

autocmd("User", {
    pattern = "AutoSaveWritePost",
    group = autosave_group,
    callback = function(opts)
        if opts.data.saved_buffer ~= nil then
            local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
            local rel_path = string.gsub(filename, vim.uv.cwd() and vim.uv.cwd() .. "/" or "", "")
            require("fidget.notification").notify(
                "[" .. vim.fn.strftime("%H:%M:%S") .. "] AutoSaved: ", vim.log.levels.INFO,
                { group = "auto-save", key = "auto-save-post-write", annote = rel_path, skip_history = true }
            )
        end
    end,
})

-- Lsp-integrated file renaming
vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions.type == "move" then
            ---@module "snacks.rename"
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
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
        -- vim.cmd.colorscheme "catppuccin"
        vim.cmd.colorscheme(_G.colorscheme) -- Set colorscheme
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

--[[ autocmd("User", {
    pattern = "VeryLazy",
    group = python_env_group,
    callback = function()
        vim.schedule(function()
            local python_env_path = vim.fn.stdpath("data") .. "/python"
            local py_activate = python_env_path .. "/bin/activate"
            local py_executable = python_env_path .. "/bin/python3"

            local abort = function(out)
                dd("Failed activating python env: " .. out.stderr)
                dd(out)
                bt()
            end

            local try_activate = function()
                local out = vim.system({
                    "source", py_activate, "&&", "pip", "install", "--upgrade", "pip", "&&",
                    "pip", "install", "neovim"
                }):wait()
                if out.code ~= 0 then
                    abort(out)
                    return
                end
                vim.g.python3_host_prog = py_executable
            end

            local init = function()
                vim.system({ "rmdir", python_env_path }):wait()
                local env_out = vim.system({ "python3", "-m", "venv", python_env_path }):wait()
                if env_out.code ~= 0 then abort(env_out) end
                try_activate()
            end

            vim.uv.fs_stat(py_activate, function(err, stat)
                dd(err, stat)
                if not stat and err then
                    init()
                    return
                end
                try_activate()
            end)

            ------------- WARN: delete below code after completing above code ---------------


            -- if stat and stat.type == "directory" then
            --     activate()
            --     return
            -- end
            --
            -- local success, err, _ = vim.uv.fs_mkdir(python_env_path, 493) -- 493 is 755 in octal
            -- if not success then
            --     vim.print("Failed to create python env directory: " .. err)
            --     return
            -- end
            --
            -- if vim.fn.has("win32") == 1 then
            --     f.async_cmd(
            --         "python -m venv "
            --         .. python_env_path
            --         .. ";  "
            --         .. python_env_path
            --         .. "/Scripts/activate && pip install --upgrade pip && pip install neovim; deactivate"
            --     )
            --     vim.g.python3_host_prog = python_env_path .. "/Scripts/python"
            -- else
            --     f.async_cmd(
            --         "mkdir -p "
            --         .. python_env_path
            --         .. " && python3 -m venv "
            --         .. python_env_path
            --         .. " && source "
            --         .. python_env_path
            --         .. "/bin/activate && pip install --upgrade pip && pip install neovim && deactivate"
            --     )
            --     vim.g.python3_host_prog = python_env_path .. "/bin/python3"
            -- end
        end)
    end,
}) ]]

autocmd({ "FileType" }, {
    group = ft_group,
    pattern = { "fugitive" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })
    end,
})
