-- Function to retrieve console output
function os.capture(cmd, raw)
    local handle = assert(io.popen(cmd, "r"))
    local output = assert(handle:read("*a"))

    handle:close()

    if raw then
        return output
    end

    output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")
    return output
end
