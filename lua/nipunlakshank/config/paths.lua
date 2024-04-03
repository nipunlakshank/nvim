package.path = package.path .. ";" .. vim.fn.expand("$XDG_CONFIG_HOME") .. "/luarocks/share/lua/5.1/?.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$XDG_CONFIG_HOME") .. "/luarocks/share/lua/5.1/?/init.lua;"
