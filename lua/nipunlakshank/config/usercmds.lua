local usercmd = vim.api.nvim_create_user_command

if Snacks then
    usercmd("Snacks", function(opts)
        Snacks[opts.args]()
    end, { nargs = 1 })
end
