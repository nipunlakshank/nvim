return {
    "vhyrro/luarocks.nvim",
    event = { "VeryLazy" },
    priority = 1001, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    opts = {
        rocks = {
            "magick",
        },
    },
}
