return {
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    ft = { "blade", "php" },
    opts = {
        close_tag_on_complete = false, -- default: true
        include_routes = true,
    },
}
