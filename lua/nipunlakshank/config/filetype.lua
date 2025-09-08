local extension = {
    http = "http",
}

local filename = {
    [".envrc"] = "sh"
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
