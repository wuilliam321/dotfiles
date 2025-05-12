return {
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-surround',
  'tpope/vim-repeat',
  {
    'mechatroner/rainbow_csv',
  },
  --{
  --  "rest-nvim/rest.nvim",
  --  config = function()
  --    ---@type rest.Opts
  --    vim.g.rest_nvim = {
  --      -- ...
  --    }
  --  end
  --},
  {
    'mbbill/undotree',
    config = function()
      vim.opt.backup = false
      vim.opt.swapfile = false
      vim.opt.writebackup = false
      vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
      vim.opt.undofile = true

      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })
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
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   --   -- refer to `:h file-pattern` for more examples
  --   --   "BufReadPre path/to/my-vault/*.md",
  --   --   "BufNewFile path/to/my-vault/*.md",
  --   -- },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "personal",
  --         path = "~/personal/notes",
  --       },
  --       {
  --         name = "work",
  --         path = "~/work/notes",
  --       },
  --     },
  --   },
  -- }
}
