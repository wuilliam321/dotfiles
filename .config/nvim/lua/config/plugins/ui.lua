return {
  'tpope/vim-commentary',
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
    config = function()
      require('todo-comments').setup {}
    end,
  },
  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        extensions = { 'quickfix', 'fugitive' },
        sections = {
          lualine_c = {
            -- {
            --   'buffers',
            --   show_filename_only = false,
            -- },
            {
              'filename',
              path = 1,
            }
          },
        }
      })
    end
  },
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
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>mb", function() harpoon:list():add() end, { desc = '[M]ark [B]uffer' })
      vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = '[M]arks [M]enu' })

      vim.keymap.set("n", "<leader>mu", function() harpoon:list():select(1) end, { desc = 'Go [M]ark [U]' })
      vim.keymap.set("n", "<leader>me", function() harpoon:list():select(2) end, { desc = 'Go [M]ark [E]' })
      vim.keymap.set("n", "<leader>mo", function() harpoon:list():select(3) end, { desc = 'Go [M]ark [O]' })
      vim.keymap.set("n", "<leader>ma", function() harpoon:list():select(4) end, { desc = 'Go [M]ark [A]' })

      -- Toggle previous & next buffers stored within Harpoon list
      -- vim.keymap.set("n", "<C-S-H>", function() harpoon:list():prev() end)
      -- vim.keymap.set("n", "<C-S-L>", function() harpoon:list():next() end)
    end,
  },
}
