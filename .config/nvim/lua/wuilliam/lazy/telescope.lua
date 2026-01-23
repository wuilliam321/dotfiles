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
      vim.keymap.set('n', '<leader>pp', builtin.git_files)
      vim.keymap.set('n', '<leader>sh', builtin.help_tags)
      vim.keymap.set('n', '<leader>sk', builtin.keymaps)
      vim.keymap.set('n', '<leader>ss', builtin.builtin)
      vim.keymap.set('n', '<leader>sw', builtin.grep_string)
      vim.keymap.set('n', '<leader>lg', builtin.live_grep)
      vim.keymap.set('n', '<leader>di', builtin.diagnostics)
      vim.keymap.set('n', '<leader>sr', builtin.resume)
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles)
      vim.keymap.set('n', '<leader><leader>', builtin.buffers)
      vim.keymap.set('n', '<leader>pg', function()
        builtin.grep_string({ search = vim.fn.input('Grep for > ', '') })
      end)
      vim.keymap.set('n', '<leader>pf', function()
        builtin.find_files { hidden = true }
      end)

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end)
    end,
  },
}
