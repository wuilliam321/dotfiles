return {
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'json', 'lua', 'markdown', 'vim', 'vimdoc', 'go', 'sql', 'jsdoc', 'c', 'http', 'yaml'},
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
}
