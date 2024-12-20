return {
    "lambdalisue/vim-suda",
    event = "CmdlineEnter",
    config = function()
        vim.api.nvim_create_user_command("W", "SudaWrite", {})
    end,
}
