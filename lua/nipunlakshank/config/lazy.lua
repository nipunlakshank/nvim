local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = "nipunlakshank.plugins"

local concurrency = nil
if jit.os:find("Windows") then
    concurrency = vim.uv.available_parallelism() * 2
else
    concurrency = vim.loop.available_parallelism()
end

local opts = {
    defaults = {
        lazy = true,
    },
    ui = {
        border = "rounded",
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    concurrency = concurrency,
    git = {
        timeout = 1200, -- kill processes that take more than 10 minutes
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {},  -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

require("lazy").setup(plugins, opts)
