local usercmd = vim.api.nvim_create_user_command

-- stylua: ignore
usercmd(
    "Snacks",
    function(opts) Snacks[opts.args]() end,
    { nargs = 1 }
)
