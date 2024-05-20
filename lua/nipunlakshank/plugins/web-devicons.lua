return {
    "nvim-tree/nvim-web-devicons",
    config = function()
        local opts = {
            override_by_extension = {
                -- ["astro"] = {
                --     icon = "𝒜",
                --     color = "#fe1003",
                --     cterm_color = "65",
                --     name = "Astro",
                -- },
            },
        }
        require("nvim-web-devicons").setup(opts)
    end,
}
