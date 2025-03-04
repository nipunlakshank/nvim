local comment_ft = require("Comment.ft")
local commentstring = { "{{--%s--}}" }
if comment_ft then
    comment_ft.set("blade", commentstring)
else
    vim.bo.commentstring = "{{-- %s --}}"
end
