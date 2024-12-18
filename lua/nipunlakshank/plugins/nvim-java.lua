return {
    "nvim-java/nvim-java",
    dependencies = {
        "nvim-java/lua-async-await",
        "nvim-java/nvim-java-core",
        "nvim-java/nvim-java-test",
        "nvim-java/nvim-java-dap",
        "MunifTanjim/nui.nvim",
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim",
    },
    ft = "java",
    config = function()
        local opts = {
            jdk = {
                auto_install = false,
            },
        }

        require("java").setup(opts)
    end,
}
