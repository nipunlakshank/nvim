return {
    "barrett-ruth/live-server.nvim",
    build = "npm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
        require("live-server").setup({
            args = {
                "--no-browser",
                "--port=5555",
                "--no-css-inject",
            },
        })
    end,
}
