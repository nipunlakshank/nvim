local M = {}

local array = {}

function array.set_of(list)
    local set = {}
    for i = 1, #list do
        set[list[i]] = true
    end
    return set
end

function array.not_contains(var, arr)
    if array.set_of(arr)[var] == nil then
        return true
    end
    return false
end

function array.contains(var, arr)
    return not array.not_contains(var, arr)
end

M.array = array

return M
