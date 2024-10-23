return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>A", function()
            harpoon:list():add()
        end, { desc = "Add current buffer to Harpoon list" })

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Toggle Harpoon quick menu" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>P", function()
            harpoon:list():prev()
        end, { desc = "Toggle to previous buffer" })

        vim.keymap.set("n", "<leader>N", function()
            harpoon:list():next()
        end, { desc = "Toggle to next buffer" })

        if vim.fn.has("mac") then -- for mac
            vim.keymap.set("n", "¡", function()
                harpoon:list():select(1)
            end, { desc = "Select Harpoon list 1" })

            vim.keymap.set("n", "™", function()
                harpoon:list():select(2)
            end, { desc = "Select Harpoon list 2" })

            vim.keymap.set("n", "£", function()
                harpoon:list():select(3)
            end, { desc = "Select Harpoon list 3" })

            vim.keymap.set("n", "¢", function()
                harpoon:list():select(4)
            end, { desc = "Select Harpoon list 4" })

            vim.keymap.set("n", "∞", function()
                harpoon:list():select(5)
            end, { desc = "Select Harpoon list 5" })
        else -- for windows and linux
            vim.keymap.set("n", "<A-1>", function()
                harpoon:list():select(1)
            end, { desc = "Select Harpoon list 1" })

            vim.keymap.set("n", "<A-2>", function()
                harpoon:list():select(2)
            end, { desc = "Select Harpoon list 2" })

            vim.keymap.set("n", "<A-3>", function()
                harpoon:list():select(3)
            end, { desc = "Select Harpoon list 3" })

            vim.keymap.set("n", "<A-4>", function()
                harpoon:list():select(4)
            end, { desc = "Select Harpoon list 4" })

            vim.keymap.set("n", "<A-5>", function()
                harpoon:list():select(5)
            end, { desc = "Select Harpoon list 5" })
        end
    end,
}
