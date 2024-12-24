return {
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
    config = function()
        local fidget = require("fidget")
        local opts = {
            notification = {
                window = {
                    winblend = 0,
                },
                override_vim_notify = true,
            },
        }

        fidget.setup(opts)
    end,
}
