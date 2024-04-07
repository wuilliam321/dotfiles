vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.showmode = false
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars:append {
  nbsp = ' ',
  space = ' ',
  tab = '  ',
  extends = '»',
  precedes = '«',
  trail = '•',
  eol = ' ',
}
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_sort_by = 'time'
vim.g.netrw_sort_direction = 'reverse'
vim.g.netrw_sort_options = 'i'
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = { 100, 140 }
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', '<C-c>', '<esc>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('x', 'x', '<Esc>')

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])

vim.keymap.set("x", "<leader>P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- { -- Useful plugin to show you pending keybinds.
  --   'folke/which-key.nvim',
  --   event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  --   config = function() -- This is the function that runs, AFTER loading
  --     require('which-key').setup()
  --
  --     -- Document existing key chains
  --     require('which-key').register {
  --       ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  --       ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  --       ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  --       ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  --       ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  --     }
  --   end,
  -- },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          path_display = { "shorten" },
        },
        pickers = {
          find_files = { theme = "ivy" },
          lsp_definitions = { theme = "ivy" },
          lsp_references = { theme = "ivy" },
          lsp_implementations = { theme = "ivy" },
          lsp_type_definitions = { theme = "ivy" },
          lsp_document_symbols = { theme = "ivy" },
          lsp_dynamic_workspace_symbols = { theme = "ivy" },
          git_files = { theme = "ivy" },
          help_tags = { theme = "ivy" },
          keymaps = { theme = "ivy" },
          builtin = { theme = "ivy" },
          grep_string = { theme = "ivy" },
          live_grep = { theme = "ivy" },
          diagnostics = { theme = "ivy" },
          resume = { theme = "ivy" },
          oldfiles = { theme = "ivy" },
          buffers = { theme = "ivy" },
        },
      }
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({ winblend = 10 }),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', vim.cmd.Ex)
      vim.keymap.set('n', '<leader>pf', function()
        builtin.find_files { hidden = true }
      end, { desc = '[P]roject [F]iles' })
      vim.keymap.set('n', '<leader>pp', builtin.git_files, { desc = '[PP] Git Files' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>pg', function()
        builtin.grep_string({ search = vim.fn.input('Grep for > ', '') })
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>di', builtin.diagnostics, { desc = 'Search [Di]agnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<C-n>', '<cmd>cnext<cr>zz')
      vim.keymap.set('n', '<C-p>', '<cmd>cprev<cr>zz')

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

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

      local servers = {
        jsonls = {},
        gopls = {
          -- cmd = { '/Users/wlacruz/.gvm/pkgsets/go1.22.1/global/bin/gopls' },
          settings = {
            gopls = {
              -- codelenses = { gc_details = false },
              usePlaceholders = true,
              buildFlags = { '-tags=integration' },
              -- hints = {
              --     -- assignVariableTypes = true,
              --     compositeLiteralFields = true,
              --     constantValues = true,
              --     -- functionTypeParameters = true, -- generics not needed for now
              --     parameterNames = true,
              --     rangeVariableTypes = true
              -- }
            },
          },
        },
        golangci_lint_ls = {
          -- cmd = { '/Users/wlacruz/.gvm/pkgsets/go1.22.1/global/bin/golangci-lint' },
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
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- {
  --     -- Autoformat
  --     'stevearc/conform.nvim',
  --     opts = {
  --         notify_on_error = false,
  --         format_on_save = {
  --             timeout_ms = 500,
  --             lsp_fallback = true,
  --         },
  --         formatters_by_ft = {
  --             lua = { 'stylua' },
  --             -- Conform can also run multiple formatters sequentially
  --             -- python = { "isort", "black" },
  --             --
  --             -- You can use a sub-list to tell conform to run *until* a formatter
  --             -- is found.
  --             -- javascript = { { "prettierd", "prettier" } },
  --         },
  --     },
  -- },

  -- Autocompletion
  { 'tzachar/cmp-tabnine',   build = './install.sh' },

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
      }
    end,
  },

  {
    'puremourning/vimspector',
    event = 'VimEnter',
    dependencies = { 'tyru/current-func-info.vim' },
    config = function()
      vim.keymap.set('n', '<leader>da', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "app" } )<cr>')
      vim.keymap.set('n', '<leader>df', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "file" } )<cr>')
      vim.keymap.set('n', '<leader>ds', '<cmd>VimspectorReset<cr>')
      vim.keymap.set('n', '<leader>bp', '<cmd>call vimspector#ToggleBreakpoint()<cr>')
      vim.keymap.set('n', '<leader>dn', '<cmd>call vimspector#StepOver()<cr>')
      vim.keymap.set('n', '<leader>dc', '<cmd>call vimspector#Continue()<cr>')

      -- uses tyru/current-func-info.vim
      vim.keymap.set(
        'n',
        '<leader>dm',
        '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "method", Test: "^" . cfi#format("%s", "") . "$" } )<cr>'
      )
    end,
  },

  {
    -- Colorscheme
    'folke/tokyonight.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      local catppuccin = require 'catppuccin'
      catppuccin.setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        custom_highlights = function(colors)
          return {
            ColorColumn = { bg = colors.surface0 },
            CursorLine = { bg = colors.surface0 },
            CursorColumn = { bg = colors.surface0 },
            Search = { bg = colors.sapphire, fg = colors.surface0 },
          }
        end,
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          gitgutter = true,
          harpoon = true,
          telescope = true,
          treesitter_context = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = false,
            },
          },
        },
      }

      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },

  -- {
  --   -- Collection of various small independent plugins/modules
  --   'echasnovski/mini.nvim',
  --   config = function()
  --     -- Better Around/Inside textobjects
  --     --
  --     -- Examples:
  --     --  - va)  - [V]isually select [A]round [)]paren
  --     --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --     --  - ci'  - [C]hange [I]nside [']quote
  --     require('mini.ai').setup { n_lines = 500 }
  --
  --     -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --     --
  --     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  --     -- - sd'   - [S]urround [D]elete [']quotes
  --     -- - sr)'  - [S]urround [R]eplace [)] [']
  --     -- require('mini.surround').setup()
  --
  --     -- Simple and easy statusline.
  --     --  You could remove this setup call if you don't like it,
  --     --  and try some other statusline plugin
  --     local statusline = require 'mini.statusline'
  --     -- set use_icons to true if you have a Nerd Font
  --     statusline.setup { use_icons = vim.g.have_nerd_font }
  --
  --     -- You can configure sections in the statusline by overriding their
  --     -- default behavior. For example, here we set the section for
  --     -- cursor location to LINE:COLUMN
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     statusline.section_location = function()
  --       return '%2l:%-2v'
  --     end
  --
  --     -- ... and there is more!
  --     --  Check out: https://github.com/echasnovski/mini.nvim
  --   end,
  -- },

  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        --- @diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'json', 'lua', 'markdown', 'vim', 'vimdoc', 'go', 'sql' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',    -- maps in normal mode to init the node/scope selection
            node_incremental = 'grn',  -- increment to the upper named parent
            scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
            node_decremental = 'grm',  -- decrement to the previous node
          },
        },
        textobjects = {
          -- syntax-aware textobjects
          enable = true,
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ['<leader>dF'] = '@function.outer',
              ['<leader>cF'] = '@class.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { [']m'] = '@function.outer' },
            goto_next_end = { [']M'] = '@function.outer' },
            goto_previous_start = { ['[m'] = '@function.outer' },
            goto_previous_end = { ['[M'] = '@function.outer' },
          },
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aC'] = '@class.outer',
              ['iC'] = '@class.inner',
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
              ['ae'] = '@block.outer',
              ['ie'] = '@block.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
              ['is'] = '@statement.inner',
              -- ['as'] = '@statement.outer',
              ['ad'] = '@comment.outer',
              ['am'] = '@call.outer',
              ['im'] = '@call.inner',
            },
          },
        },
      }

      require('treesitter-context').setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      }
    end,
  },

  {
    'ThePrimeagen/harpoon',
    config = function()
      local harpoon = require 'harpoon'
      local ui = require 'harpoon.ui'
      local mark = require 'harpoon.mark'
      local term = require 'harpoon.term'

      harpoon.setup {
        projects = {
          ['~/onboarding/fury_rampup-wuilliam-lacruz'] = {
            term = {
              cmds = {
                'go test ./...\n',
                'fury run 21001\n',
              },
            },
          },
          ['~/work/fury_bari-transaction-channel'] = {
            term = {
              cmds = {
                'make test\n',
                'make run\n',
              },
            },
          },
          ['~/work/fury_bari-transactor'] = {
            term = {
              cmds = {
                'make test\n',
                'make run\n',
              },
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>mb', function()
        mark.add_file()
      end)
      vim.keymap.set('n', '<leader>mu', function()
        ui.nav_file(1)
      end)
      vim.keymap.set('n', '<leader>me', function()
        ui.nav_file(2)
      end)
      vim.keymap.set('n', '<leader>mo', function()
        ui.nav_file(3)
      end)
      vim.keymap.set('n', '<leader>ma', function()
        ui.nav_file(4)
      end)
      vim.keymap.set('n', '<leader>mm', function()
        ui.toggle_quick_menu()
      end)
      vim.keymap.set('n', '<leader>tu', function()
        term.gotoTerminal(1)
      end)
      vim.keymap.set('n', '<leader>te', function()
        term.gotoTerminal(2)
      end)
      vim.keymap.set('n', '<leader>to', function()
        term.gotoTerminal(3)
      end)
      vim.keymap.set('n', '<leader>ta', function()
        term.gotoTerminal(4)
      end)
    end,
  },

  {
    'airblade/vim-gitgutter',
    config = function()
      vim.keymap.set('n', '<leader>ghp', '@<Plug>(GitGutterPreviewHunk)')
      vim.keymap.set('n', '<leader>ghu', '@<Plug>(GitGutterUndoHunk)')
      vim.keymap.set('n', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.keymap.set('x', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.cmd([[GitGutterSignsDisable]])
    end,
  },

  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.G)
    end,
  },
  'mechatroner/rainbow_csv',

  {
    'mbbill/undotree',
    config = function()
      vim.opt.backup = false
      vim.opt.swapfile = false
      vim.opt.writebackup = false
      vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
      vim.opt.undofile = true

      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },

  {
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      local refactoring = require 'refactoring'
      refactoring.setup {
        -- prompt for return type
        prompt_func_return_type = { go = true, ts = true },
        -- prompt for function parameters
        prompt_func_param_type = { go = true, ts = true },
        formatting = {
          go = {
            cmd = ':lua vim.lsp.buf.format()',
          },
        },
      }

      -- Remaps for the refactoring operations currently offered by the plugin
      local opts = { noremap = true, silent = true, expr = false }
      -- Remaps for the refactoring operations currently offered by the plugin
      vim.api.nvim_set_keymap('v', '<leader>re',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
      vim.api.nvim_set_keymap('v', '<leader>rf',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
      vim.api.nvim_set_keymap('v', '<leader>rv',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)
      vim.api.nvim_set_keymap('v', '<leader>ri',
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)

      -- Extract block doesn't need visual mode
      vim.api.nvim_set_keymap('n', '<leader>rb', [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>rbf', [[ :lua require('refactoring').refactor('Extract Block To File')<CR>]],
        opts)

      -- Inline variable can also pick up the identifier currently under the cursor without visual mode
      vim.api.nvim_set_keymap('n', '<leader>ri', [[ :lua require('refactoring').refactor('Inline Variable')<CR>]], opts)

      vim.api.nvim_set_keymap('v', '<leader>rr', "<Esc><Cmd>lua require('refactoring').select_refactor()<CR>", opts)

      -- local telescope = require('telescope')
      -- vim.keymap.set('v', '<leader>rr', telescope.extensions.refactoring.refactors, mapping_opts)
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_filetypes = { VimspectorPrompt = false }
    end,
  },
  {
    'wuilliam321/nvim-autorun',
    dir = '~/personal/nvim-autorun',
    config = function()
      vim.defer_fn(function()
        local w = math.floor(vim.api.nvim_win_get_width(0))
        local h = math.floor(vim.api.nvim_win_get_height(0) / 4)
        --- @diagnostic disable-next-line: redundant-parameter
        require('autorun').setup({
          show_returns = true,
          go_tests = true,
          window = {
            relative = 'editor',
            height = h,
            width = w,
            top = h * 3,
            left = 0,
            style = 'minimal',
            border = 'double',
            transparent = 10,
          }
        })
      end, 2000)
    end
  },
  -- {
  --   '/Users/wlacruz/personal/nvim-iso8583',
  --   dir = '~/personal/nvim-iso8583',
  --   config = function()
  --     require('iso8583').setup({
  --       cmd = "/Users/wlacruz/work/parser/bin/iso8583",
  --     })
  --   end
  -- },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
