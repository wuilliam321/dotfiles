return {
  {
    'folke/tokyonight.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
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
      vim.cmd.colorscheme 'tokyonight-night' -- tokyonight-night catppuccin
    end,
  },
}
