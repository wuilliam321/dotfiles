return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     local params = vim.lsp.util.make_range_params()
      --     params.context = { only = { "source.organizeImports" } }
      --     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      --     for cid, res in pairs(result or {}) do
      --       for _, r in pairs(res.result or {}) do
      --         if r.edit then
      --           local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
      --           vim.lsp.util.apply_workspace_edit(r.edit, enc)
      --         end
      --       end
      --     end
      --     vim.lsp.buf.format({ async = false })
      --   end
      -- })

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
          vim.lsp.inlay_hint.enable()
          vim.cmd.hi 'LspInlayHint gui=none,italic'

          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
            { desc = 'Go to previous [D]iagnostic message' })
          vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end,
            { desc = 'Go to next [D]iagnostic message' })
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
            { desc = 'Show [D]iagnostic [F]loat error messages' })
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

      vim.filetype.add {
        pattern = {
          ['swagger.*%.ya?ml'] = 'yaml.openapi',
          ['openapi.*%.ya?ml'] = 'yaml.openapi',
          ['openapi.*%.json'] = 'json.openapi',
        },
      }

      local servers = {
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = '@vue/typescript-plugin',
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                  }
                },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        },
        eslint = {},
        jsonls = {},
        pyright = {},
        vacuum = {},
        gopls = {
          cmd = { '/Users/wlacruz/go/bin/gopls' },
          settings = {
            gopls = {
              ["formatting.local"] = (function()
                if vim.fn.executable("go") ~= 1 then
                  return
                end
                local module = vim.fn.trim(vim.fn.system("go list -m"))
                if vim.v.shell_error ~= 0 then
                  return
                end
                return module:gsub("\n", ",")
              end)(),
              usePlaceholders = true,
              buildFlags = { '-tags=integration' },
              hints = {
                compositeLiteralFields = true,
                parameterNames = true,
                rangeVariableTypes = true
              }
            },
          },
        },
        golangci_lint_ls = {
          cmd = { '/Users/wlacruz/go/bin/golangci-lint-langserver' },
        },
        -- lua_ls = {
        --   cmd = { '/opt/homebrew/bin/lua-language-server' },
        --   settings = {
        --     Lua = {},
        --   },
        -- },
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, config or {})
        vim.lsp.enable(server)
      end

      vim.lsp.config("*", {
        capabilities = vim.lsp.protocol.make_client_capabilities()
      })
    end,
  },
  {
    'saghen/blink.compat',
    -- use v2.* for blink.cmp v1.*
    version = '2.*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
      'saghen/blink.compat',
      -- 'rafamadriz/friendly-snippets',
      'Kaiser-Yang/blink-cmp-avante',
      'saghen/blink.compat',
      'L3MON4D3/LuaSnip',
      version = 'v2.*'
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal'
      },

      -- (Default) Only show the documentation popup when manually triggered
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
          border = "rounded",
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = false,
          show_with_menu = true,
        },
        menu = {
          border = "rounded",
          auto_show = true,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' }
            },
            treesitter = { 'lsp' },
          },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        -- default = { 'lsp', 'path', 'snippets', 'buffer', "avante_commands", "avante_mentions", "avante_files" },
        -- default = { 'lsp', 'path', 'snippets', 'buffer'},
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },

          -- avante_commands = {
          --   name = "avante_commands",
          --   module = "blink.compat.source",
          --   score_offset = 90, -- show at a higher priority than lsp
          --   opts = {},
          -- },
          -- avante_files = {
          --   name = "avante_files",
          --   module = "blink.compat.source",
          --   score_offset = 100, -- show at a higher priority than lsp
          --   opts = {},
          -- },
          -- avante_mentions = {
          --   name = "avante_mentions",
          --   module = "blink.compat.source",
          --   score_offset = 1000, -- show at a higher priority than lsp
          --   opts = {},
          -- }
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
