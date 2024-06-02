return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
        { "folke/neodev.nvim", optional = true },
        { "folke/lazydev.nvim", optional = true },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup()
        require("dap-go").setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<leader>B", dap.set_breakpoint, {})
        vim.keymap.set("n", "<leader>dc", dap.continue, {})
        vim.keymap.set("n", "<leader>dl", dap.run_last, {})
    end,
}
