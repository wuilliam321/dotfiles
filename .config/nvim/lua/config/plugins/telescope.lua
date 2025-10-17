return {
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
          path_display = { "smart" },
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
      -- vim.keymap.set('n', '<leader>ff', '<cmd>Oil<cr>', { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>ff', ':Ex<cr>', { desc = '[F]ind [F]iles' })
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
      vim.keymap.set('n', 'n', 'nzz')
      vim.keymap.set('n', 'b', 'bzz')

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
}
