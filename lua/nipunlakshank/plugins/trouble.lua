return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        -- stylua: ignore start
        { "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
        { "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
        { "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
        { "<leader>tL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
        { "<leader>tq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
        -- stylua: ignore end
    },
    config = function()
        local trouble = require("trouble")

        local opts = {}

        trouble.setup(opts)
    end,
}
