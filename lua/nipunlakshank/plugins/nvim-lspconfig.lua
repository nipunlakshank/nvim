return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        -- "creativenull/efmls-configs-nvim",
    },
    config = function()
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local on_attach = require("nipunlakshank.utils.lsp").on_attach
        local diagnostic_signs = require("nipunlakshank.utils.icons").diagnostic_signs
        local typescript_organise_imports = require("nipunlakshank.utils.lsp").typescript_organise_imports

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        for type, icon in pairs(diagnostic_signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- lua
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                        disable = { "missing-parameters", "missing-fields" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- typescript
        lspconfig.tsserver.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "typescript",
                "javascript",
                "typescriptreact",
                "javascriptreact",
            },
            commands = {
                TypeScriptOrganizeImports = typescript_organise_imports,
            },
            settings = {
                typescript = {
                    indentStyle = "space",
                    indentSize = 4,
                },
            },
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
        })

        -- bash
        lspconfig.bashls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "sh", "zsh", "aliasrc" },
        })

        -- solidity
        lspconfig.solidity.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "solidity" },
        })

        -- php
        lspconfig.intelephense.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = function(pattern)
                local cwd = vim.loop.cwd()
                local root = util.root_pattern(
                    "composer.json",
                    ".git",
                    ".gitignore",
                    ".env",
                    ".env.example",
                    ".htaccess",
                    ".htpasswd"
                )(pattern)

                if not root then
                    return cwd
                end

                return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant
            end,
        })

        -- java
        lspconfig.jdtls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "java" },
            cmd = { "jdtls" },
            root_dir = function(pattern)
                local cwd = vim.loop.cwd()
                local root = lspconfig.util.root_pattern("gradlew", ".git", "mvnw", "pom.xml")(pattern)

                if not root then
                    return cwd
                end

                return util.path.is_descendant(cwd, root) and cwd or root -- prefer cwd if root is a descendant
            end,
        })

        -- docker
        lspconfig.dockerls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- dotenv
        lspconfig.dotls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            name = "dot",
            cmd = { "dot-language-server", "--stdio" },
            filetypes = { "dot" },
        })

        -- C/C++
        lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "clangd",
                "--offset-encoding=utf-16",
            },
        })

        -- emmet
        lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "css",
                "eruby",
                "html",
                "php",
                "phtml",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "svelte",
                "vue",
                "less",
                "sass",
                "scss",
                "pug",
            },
            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            -- **Note:** only the options listed in the table are supported.
            init_options = {
                ---@type table<string, string>
                includeLanguages = {},
                --- @type string[]
                excludeLanguages = {},
                --- @type string[]
                extensionsPath = {},
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                preferences = {},
                --- @type boolean Defaults to `true`
                showAbbreviationSuggestions = true,
                --- @type "always" | "never" Defaults to `"always"`
                showExpandedAbbreviation = "always",
                --- @type boolean Defaults to `false`
                showSuggestionsAsSnippets = true,
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                syntaxProfiles = {},
                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                variables = {},
            },
        })

        -- configure efm server
        -- local luacheck = require("efmls-configs.linters.luacheck")
        -- local stylua = require("efmls-configs.formatters.stylua")
        -- local flake8 = require("efmls-configs.linters.flake8")
        -- local black = require("efmls-configs.formatters.black")
        -- local eslint = require("efmls-configs.linters.eslint")
        -- local prettier_d = require("efmls-configs.formatters.prettier_d")
        -- local fixjson = require("efmls-configs.formatters.fixjson")
        -- local shellcheck = require("efmls-configs.linters.shellcheck")
        -- local shfmt = require("efmls-configs.formatters.shfmt")
        -- local hadolint = require("efmls-configs.linters.hadolint")
        -- local solhint = require("efmls-configs.linters.solhint")
        -- local cpplint = require("efmls-configs.linters.cpplint")
        -- local clangformat = require("efmls-configs.formatters.clang_format")

        -- lspconfig.efm.setup({
        -- 	filetypes = {
        -- 		"lua",
        -- 		"python",
        -- 		"json",
        -- 		"jsonc",
        -- 		"sh",
        -- 		"javascript",
        -- 		"javascriptreact",
        -- 		"typescript",
        -- 		"typescriptreact",
        -- 		"svelte",
        -- 		"vue",
        -- 		"markdown",
        -- 		"docker",
        -- 		"solidity",
        -- 		"html",
        -- 		"php",
        -- 		"blade",
        -- 		"phtml",
        -- 		"css",
        -- 		"c",
        -- 		"cpp",
        -- 	},
        -- 	init_options = {
        -- 		documentFormatting = true,
        -- 		documentRangeFormatting = true,
        -- 		hover = true,
        -- 		documentSymbol = true,
        -- 		codeAction = true,
        -- 		completion = true,
        -- 	},
        -- 	settings = {
        -- 		languages = {
        -- 			lua = { luacheck, stylua },
        -- 			python = { flake8, black },
        -- 			typescript = { eslint, prettier_d },
        -- 			json = { eslint, fixjson },
        -- 			jsonc = { eslint, fixjson },
        -- 			sh = { shellcheck, shfmt },
        -- 			javascript = { eslint, prettier_d },
        -- 			javascriptreact = { eslint, prettier_d },
        -- 			typescriptreact = { eslint, prettier_d },
        -- 			svelte = { eslint, prettier_d },
        -- 			vue = { eslint, prettier_d },
        -- 			markdown = { prettier_d },
        -- 			docker = { hadolint, prettier_d },
        -- 			solidity = { solhint },
        -- 			html = { prettier_d },
        -- 			css = { prettier_d },
        -- 			php = { prettier_d },
        -- 			c = { clangformat, cpplint },
        -- 			cpp = { clangformat, cpplint },
        -- 		},
        -- 	},
        -- })
    end,
}
