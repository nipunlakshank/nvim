local usercmd = vim.api.nvim_create_user_command

vim.cmd([[
    function! Redir(cmd)
        for win in range(1, winnr('$'))
            if getwinvar(win, 'scratch')
                execute win . 'windo close'
            endif
        endfor
        if a:cmd =~ '^!'
            execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
        else
            redir => output
            execute a:cmd
            redir END
        endif
        new
        let w:scratch = 1
        setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile filetype=redir_scratch
        nnoremap q :q<cr>
        call setline(1, split(output, "\n"))
        setlocal nomodifiable
        ColorizerAttachToBuffer
    endfunction

    command! -nargs=1 Redir silent call Redir(<f-args>)
]])

usercmd("Hi", function(_)
    vim.cmd("Redir hi")
end, { nargs = 0 })

---@module "snacks"
if Snacks then
    usercmd("Snacks", function(opts)
        local input = opts.args
        local sep = "%s"
        local cmd = ""
        local args = ""
        for str in string.gmatch(input, "([^" .. sep .. "]+)") do
            if cmd ~= "" then
                args = args .. " " .. str
            else
                cmd = str
            end
        end
        Snacks[cmd](args)
    end, { nargs = "+" })
end
