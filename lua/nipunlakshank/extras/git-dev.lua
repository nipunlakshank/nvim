--- @param persist boolean @Whether to persist the repository or not (default: false)
--- @return string, table @Repository name/uri and options
local get_opts = function(persist)
    local opts = {}
    opts.ephemeral = not persist

    local repo = vim.fn.input("Repository name/uri: ")

    if repo ~= "" then

        if vim.fn.match(repo, "https://github.com") == 0 or vim.fn.match(repo, "git@github.com") == 0 then
            print("Full link supplied. matched at: " .. vim.fn.match(repo, "https://github.com") .. " or " .. vim.fn.match(repo, "git@gihub.com") .. "\n" .. vim.inspect(opts))
            return repo, opts
        end

        opts.git = {}

        if vim.fn.match(repo, "/") ~= -1 then
            opts.git.base_uri_format = "https://github.com/%s.git"
            return repo, opts
        end

        local default_user = vim.fn.expand("$GH_USER")

        if default_user == "$GH_USER" then
            opts.git.default_org = vim.fn.input("GitHub username: ")
        else
            opts.git.default_org = default_user
        end
        opts.git.base_uri_format = "git@github.com:%s.git"

        return repo, opts
    end
    return repo, {}
end

return {
    "moyiz/git-dev.nvim",
    event = "VeryLazy",
    optional = true,
    opts = {
        read_only = false,
    },
    keys = {
        {
            "<leader>go",
            function()
                local repo = ''
                local opts = {}
                repo, opts = get_opts(false)
                if repo ~= '' and type(opts) == "table" then
                    print("Opening: " .. repo, vim.inspect(opts))
                    require("git-dev").open(repo, {}, opts)
                end
            end,
            desc = "[O]pen a remote git repository (temporarily)",
        },
        {
            "<leader>gO",
            function()
                local repo = ''
                local opts = {}
                repo, opts = get_opts(true)
                if repo ~= '' and type(opts) == "table" then
                    require("git-dev").open(repo, {}, opts)
                end
            end,
            desc = "[O]pen a remote git repository (persist)",
        },
    },
}
