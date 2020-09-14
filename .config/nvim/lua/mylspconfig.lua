local nvim_lsp = require'nvim_lsp'

nvim_lsp.vuels.setup{}
nvim_lsp.gopls.setup{}
nvim_lsp.html.setup{}
nvim_lsp.jsonls.setup{}
nvim_lsp.pyls.setup{}
nvim_lsp.jdtls.setup{}

nvim_lsp.tsserver.setup{
  root_dir = nvim_lsp.util.root_pattern("tsconfig.json", ".git");
}

local lua_server_path = "/home/wuilliam.lacruz/Downloads/lua-language-server/"
nvim_lsp.sumneko_lua.setup{
  cmd = {
    lua_server_path .. "bin/Linux/lua-language-server", "-E",
    lua_server_path .. "main.lua"
  }
}
