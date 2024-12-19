local extension = {
    http = "http",
}

local filename = {
    -- [".env"] = "dotenv"
}

local pattern = {
    [".*/git/config"] = "gitconfig",
    [".*_git/config"] = "gitconfig",
    [".*/%.env"] = "dotenv",
    [".*/%.env%..*"] = "dotenv",
    [".*%.blade%.php"] = "blade",
}

vim.filetype.add({
    extension = extension,
    filename = filename,
    pattern = pattern,
})
