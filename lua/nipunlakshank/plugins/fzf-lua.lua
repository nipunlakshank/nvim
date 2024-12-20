return {
    "ibhagwan/fzf-lua",
    event = { "VimEnter" },
    -- optional for icon support
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end
}
