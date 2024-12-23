return {
    "ibhagwan/fzf-lua",
    event = { "VimEnter" },
    -- optional for icon support
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            "telescope",
            hls = {
                border = "FloatBorder",
                fzf_colors = true,
            },
        })

        local config = require("fzf-lua.config")
        local actions = require("trouble.sources.fzf").actions
        config.defaults.actions.files["ctrl-t"] = actions.open
    end,
}
