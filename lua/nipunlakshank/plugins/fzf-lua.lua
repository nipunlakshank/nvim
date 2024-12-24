return {
    "ibhagwan/fzf-lua",
    event = { "VeryLazy" },
    -- optional for icon support
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local fzflua = require("fzf-lua")
        -- calling `setup` is optional for customization
        fzflua.setup({
            "telescope",
            hls = {
                border = "FloatBorder",
                fzf_colors = true,
            },
        })

        local config = require("fzf-lua.config")
        local actions = require("trouble.sources.fzf").actions
        config.defaults.actions.files["ctrl-t"] = actions.open

        require("fzf-lua.providers.ui_select").register({ winopts = { height = 0.33, width = 0.40 } })
    end,
}
