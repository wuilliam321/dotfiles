local lspconfig = require('lspconfig')

local language_servers = {
  'html',
  'cssls',
  eslint = {
    settings = {
      packageManager = 'yarn',
    },
  },
  vuels = {
    settings = {
      vetur = {
        completion = {
          autoImport = true,
          useScaffoldSnippets = true
        },
        format = {
          enable = true,
          defaultFormatter = {
            html = "prettier",
            js = "prettier",
            ts = "prettier",
          }
        },
        validation = {
          template = true,
          script = true,
          style = true,
          templateProps = true,
          interpolation = true
        },
        useWorkspaceDependencies = true,
        -- experimental = {
        --   templateInterpolationService = true
        -- }
      },
    },
  },
  'jsonls',
  'pylsp',
  'groovyls',
  'clangd',
  'dockerls',
  'yamlls',
  'terraformls',
  sqlls = {
      settings = {
          sqlls = {
              connections = {
                  {
                      driver = 'postgresql',
                      dataSourceName = 'host=localhost port=25435 user=test password=test dbname=test sslmode=disable',
                  },
              },
          },
      },
  },
  kotlin_language_server = {
    settings = {kotlin = {compiler = {jvm = {target = '1.8'}}}},
    cmd = {
      '/Users/wuilliam.lacruz/Downloads/kotlin-language-server/' ..
        'server/build/install/server/bin/kotlin-language-server',
    },
    filetypes = {'kotlin'},
  },
  gopls = {
    settings = {
      gopls = {
        codelenses = {gc_details = false},
        usePlaceholders = true,
        buildFlags = {'-tags=integration'},
      },
    },
  },
  golangci_lint_ls = {
    init_options = {
      command = {
        'golangci-lint',
        'run',
        '-E',
        'deadcode',
        '-E',
        'errcheck',
        '-E',
        'gosimple',
        '-E',
        'govet',
        '-E',
        'ineffassign',
        '-E',
        'staticcheck',
        '-E',
        'structcheck',
        '-E',
        'typecheck',
        '-E',
        'unused',
        '-E',
        'varcheck',
        '--out-format',
        'json',
      },
    },
  },
  tsserver = {root_dir = lspconfig.util.root_pattern('tsconfig.json', '.git')},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {spacing = 4, prefix = '~'},
    signs = function(bufnr)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      if not ok then return true end
      return result
    end,
  })

local capabilities = (function()
  local c = vim.lsp.protocol.make_client_capabilities()
  c = require('cmp_nvim_lsp').default_capabilities(c)
  c.textDocument.completion.completionItem.snippetSupport = true
  c.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'},
  }
  return c
end)()

local on_attach = function(client)
  if client.server_capabilities.document_highlight then
    vim.cmd[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.server_capabilities.code_lens then
    vim.cmd[[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end
end

for idx, cfg in pairs(language_servers) do
  local lang = cfg
  local opts = {capabilities = capabilities, on_attach = on_attach}
  if cfg ~= nil and type(cfg) == 'table' then
    lang = idx
    opts = vim.tbl_deep_extend('force', opts, cfg)
  end
  lspconfig[lang].setup(opts)
end
