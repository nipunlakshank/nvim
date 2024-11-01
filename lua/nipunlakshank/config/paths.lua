-- if vim.fn.has("win32") == 1 then
--     package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "\\AppData\\Roaming/luarocks/share/lua/5.1/?.lua;"
--     package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "\\AppData\\Roaming/luarocks/share/lua/5.1/?/init.lua;"
--     package.path = package.path .. ";" .. "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree/share/lua/5.1/?.lua;"
--     package.path = package.path .. ";" .. "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree/share/lua/5.1/?/init.lua;"
--     package.path = package.path .. ";" .. "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\lua\\?.lua;"
--     package.path = package.path .. ";" .. "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\lua\\?\\init.lua;"
-- end
package.path = package.path .. ";" .. vim.fn.expand("~/.luarocks/share/lua/5.1/?/init.lua;")
package.path = package.path .. ";" .. vim.fn.expand("~/.luarocks/share/lua/5.1/?.lua;")
