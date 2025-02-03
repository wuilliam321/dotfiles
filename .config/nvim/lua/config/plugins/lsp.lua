return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.lsp.inlay_hint.enable()

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end
      })

      local border = {
        { '┌', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '┐', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '┘', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '└', 'FloatBorder' },
        { '│', 'FloatBorder' },
      }

      -- To instead override globally
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
            { desc = 'Go to previous [D]iagnostic message' })
          vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end,
            { desc = 'Go to next [D]iagnostic message' })
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
            { desc = 'Show diagnostic [E]rror messages' })
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
            { desc = 'Open diagnostic [Q]uickfix list' })

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('go', require('telescope.builtin').lsp_type_definitions, '[G]oto Type Definiti[o]n')
          map('<leader>dS', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>fd', vim.lsp.buf.format, '[F]ormat')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>oi', function()
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
          end, '[O]rganize [I]mports')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      --- @diagnostic disable-next-line: cast-local-type
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


      -- LSP settings (for overriding per client)
      -- local handlers = {
      --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      --   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      -- }

      local servers = {
        ts_ls = {},
        eslint = {},
        jsonls = {},
        pylsp = {},
        gopls = {
          -- handlers = handlers,
          -- cmd = { '/Users/wlacruz/go/bin/gopls' },
          settings = {
            gopls = {
              ["formatting.local"] = (function()
                -- organize imports in groups
                if vim.fn.executable("go") ~= 1 then
                  return
                end
                local module = vim.fn.trim(vim.fn.system("go list -m"))
                if vim.v.shell_error ~= 0 then
                  return
                end
                return module:gsub("\n", ",")
              end)(),
              -- codelenses = { gc_details = false },
              usePlaceholders = true,
              buildFlags = { '-tags=integration' },
              hints = {
                -- assignVariableTypes = true,
                compositeLiteralFields = true,
                -- compositeLiteralTypes = true,
                -- constantValues = true,
                -- functionTypeParameters = true, -- generics not needed for now
                parameterNames = true,
                rangeVariableTypes = true
              }
            },
          },
        },
        golangci_lint_ls = {
          -- cmd = { '/Users/wlacruz/go/bin/golangci-lint' },
        },
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            -- if server_name == "tsserver" then
            --   server_name = "ts_ls"
            -- end
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping.complete {},
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'cmp_tabnine' },
        },
        formatting = {
          -- onsails/lspkind-nvim
          format = function(entry, vim_item)
            local source_mapping = {
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              cmp_tabnine = '[TN]',
              luasnip = '[Snippet]',
              path = '[Path]',
            }

            -- local lspkind = require('lspkind')
            -- if not lspkind then
            --   return
            -- end
            --
            -- vim_item.kind = lspkind.symbolic(vim_item.kind, {
            --   mode = "symbol",
            --   ellipsis_char = '...',
            -- })
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
              local detail = (entry.completion_item.labelDetails or {}).detail
              vim_item.kind = ""
              if detail and detail:find('.*%%.*') then
                vim_item.kind = vim_item.kind .. ' ' .. detail
              end

              if (entry.completion_item.data or {}).multiline then
                vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
              end
            end
            local maxwidth = 50
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
}
