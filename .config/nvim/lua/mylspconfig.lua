local nvim_lsp = require'nvim_lsp'

local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

nvim_lsp.vuels.setup{on_attach=on_attach_vim}
nvim_lsp.gopls.setup{on_attach=on_attach_vim}
nvim_lsp.html.setup{on_attach=on_attach_vim}
nvim_lsp.jsonls.setup{on_attach=on_attach_vim}
nvim_lsp.pyls.setup{on_attach=on_attach_vim}
nvim_lsp.jdtls.setup{on_attach=on_attach_vim}
nvim_lsp.groovyls.setup{on_attach=require'completion'.on_attach}

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
