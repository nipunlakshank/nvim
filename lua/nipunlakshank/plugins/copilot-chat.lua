return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        event = { "BufRead", "BufNewFile" },
        keys = {
            {
                "<leader>ccq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - Quick chat",
            }
        },
        config = function()
            local copilot = require("CopilotChat")
            copilot.setup({
                system_prompt = "How can I assist you today?",
                model = 'gpt-4o',
                temperature = 0.5,
                window = {
                    layout = 'vertical',
                    width = 0.5,
                    height = 0.5,
                    border = 'rounded',
                    title = 'Copilot Chat',
                },
                show_help = true,
                show_folds = true,
                highlight_selection = true,
                highlight_headers = true,
                auto_follow_cursor = true,
                auto_insert_mode = false,
                insert_at_end = false,
                clear_chat_on_new_prompt = false,
                log_level = 'info',
                chat_autocomplete = true,
                history_path = vim.fn.stdpath('data') .. '/copilotchat_history',
                question_header = '# User ',
                answer_header = '# Copilot ',
                error_header = '# Error ',
                separator = '───',
            })
        end
    },
}
