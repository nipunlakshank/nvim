return {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>F",
            function()
                local async = false
                if vim.tbl_contains({ "blade" }, vim.bo[0].filetype) then
                    async = true
                end
                require("conform").format({ async = async })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, { desc = "Disable autoformat-on-save", bang = true })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, { desc = "Re-enable autoformat-on-save" })
    end,
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua", lsp_format = "prefer" },
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true },
                blade = { "blade-formatter", timeout_ms = 1000 },
                php = { "pint", lsp_format = "fallback", stop_after_first = false },
                html = { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true },
                css = { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true },
                nix = { "nixfmt", lsp_format = "prefer", stop_after_first = true },
            },
            default_format_opts = { lsp_format = "fallback" },
            format_on_save = function(bufnr)
                -- Disable autoformat on certain filetypes
                local ignore_filetypes = { "sql", "mysql", "harpoon" }

                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end

                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                -- Disable autoformat for files in a certain path
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match("/node_modules/") then
                    return
                end

                -- local timeout = 500
                -- if vim.tbl_contains({ "blade" }, vim.bo[bufnr].filetype) then
                --     timeout = 1000
                -- end

                -- local lsp_format = "fallback"
                -- if vim.tbl_contains({ "lua", "javascript", "typescript" }, vim.bo[bufnr].filetype) then
                --     lsp_format = "prefer"
                -- end

                return {
                    -- timeout_ms = timeout,
                    -- lsp_format = lsp_format,
                }
            end,
        })
    end,
}
