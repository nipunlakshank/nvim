return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local keymap = require("nipunlakshank.utils.keymap")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        keymap
            .modes("n")
            .lhs({ default = "<A-h>", mac = "˙" })
            .rhs(function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            .opts({ desc = "Toggle Harpoon quick menu" })
            .set()

        keymap
            .modes("n")
            .lhs("<leader>A")
            .rhs(function() harpoon:list():add() end)
            .opts({ desc = "Add current buffer to Harpoon list" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-.>", mac = "≥" })
            .rhs(function() harpoon:list():next() end)
            .opts({ desc = "Harpoon go to next buffer" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-,>", mac = "≤" })
            .rhs(function() harpoon:list():prev() end)
            .opts({ desc = "Harpoon go to previous buffer" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-a>", mac = "å" })
            .rhs(function() harpoon:list():select(1) end)
            .opts({ desc = "Select Harpoon list 1" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-s>", mac = "ß" })
            .rhs(function() harpoon:list():select(2) end)
            .opts({ desc = "Select Harpoon list 2" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-d>", mac = "∂" })
            .rhs(function() harpoon:list():select(3) end)
            .opts({ desc = "Select Harpoon list 3" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-f>", mac = "ƒ" })
            .rhs(function() harpoon:list():select(4) end)
            .opts({ desc = "Select Harpoon list 4" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-q>", mac = "œ" })
            .rhs(function() harpoon:list():select(5) end)
            .opts({ desc = "Select Harpoon list 5" })
            .set()

        keymap
            .modes("n")
            .lhs({ default = "<A-w>", mac = "∑" })
            .rhs(function() harpoon:list():select(6) end)
            .opts({ desc = "Select Harpoon list 6" })
            .set()
    end,
}
