return {
    "gbprod/phpactor.nvim",
    build = function()
        require("phpactor.handler.update")()
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        install = {
            path = vim.fn.stdpath("data") .. "/opt/",
            branch = "master",
            bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
            php_bin = "php",
            composer_bin = "composer",
            git_bin = "git",
            check_on_startup = "none",
        },
        lspconfig = {
            enabled = true,
            options = {},
        },
    },
}
