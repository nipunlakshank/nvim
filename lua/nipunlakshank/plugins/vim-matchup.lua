return {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
}
