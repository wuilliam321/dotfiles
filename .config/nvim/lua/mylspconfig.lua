local nvim_lsp = require'nvim_lsp'

local lua_server_path = "/home/wuilliam.lacruz/Downloads/lua-language-server/"
nvim_lsp.sumneko_lua.setup{
  cmd = {
    lua_server_path .. "bin/Linux/lua-language-server", "-E",
    lua_server_path .. "main.lua"
  }
}
