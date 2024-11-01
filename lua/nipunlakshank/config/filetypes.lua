local extension = {}

local filename = {}

local pattern = {
    [".*/git/config"] = "gitconfig",
    [".*_git/config"] = "gitconfig",
}

vim.filetype.add({
    extension = extension,
    filename = filename,
    pattern = pattern,
})
