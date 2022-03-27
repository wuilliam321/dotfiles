local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local from_entry = require "telescope.from_entry"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local make_entry = require "telescope.make_entry"

local conf = require("telescope.config").values

-- Dropdown list theme using a builtin theme definitions :
local no_preview = require'telescope.themes'.get_dropdown({
  winblend = 10,
  prompt = " > ",
  previewer = false,
  path_display = {
    smart = 1,
  }
})

-- Settings for with preview option
local with_preview = require'telescope.themes'.get_dropdown({
  winblend = 10,
  prompt = " > ",
  results_title = false,
  path_display = {
    smart = 1,
  }
})

-- in lua/finders.lua
local M = {}

M.actions_golang = function()
  local _opts = vim.deepcopy(no_preview)
  local results = {
    {'GoFillStruct', 'Autofill struct'},
    {'GoAddTag', 'Add struct tags'},
    {'GoRmTag', 'Remove struct tags'},
    {'GoClearTag', 'Clear struct tags'},
    {'GoImport', 'Format file'},
    {'GoTest', 'Run all tests'},
    {'GoTestPkg', 'Run package tests'},
    {'GoTestFile', 'Run file tests'},
    {'GoTestFunc', 'Run current function tests'},
  }
  pickers.new(_opts, {
    prompt_title = "Go Actions",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          ordinal = entry[2] .. " " .. entry[1],
          cmd = entry[1],
          display = entry[2],
        }
      end,
    },
    previewer = previewers.help.new(_opts),
    sorter = conf.generic_sorter(_opts),
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local entry = action_state.get_selected_entry()
        local command = entry.cmd
        actions.close(prompt_bufnr)
        vim.cmd([[silent! ]] .. command)
      end)
      return true
    end,
  }):find()
end

M.cheatsheets = function(opts)
  local _opts = vim.deepcopy(no_preview)
  _opts.search = vim.fn.input("cht.sh > ")
  _opts.prompt_title = "Available languages (Cheat.sh)"

  if _opts.search == "" then
    return
  end

  local languages = {
    {filetype = "go", name = "Golang"},
    {filetype = "js", name = "Javascript"},
    {filetype = "markdown", name = "Markdown"},
    -- "typescript", {filetype = "ts", name = "TypeScript"}},
    -- "typescriptreact", {filetype = "tsx", name = "TypeScript React"}},
    -- "json", {filetype = "json", name = "JSON"}},
    -- "python", {filetype = "python", name = "Python"}},
    -- "ruby", {filetype = "ruby", name = "Ruby"}},
    -- "shell", {filetype = "shell", name = "Shell"}},
    -- "yaml", {filetype = "yaml", name = "YAML"}},
    -- "xml", {filetype = "xml", name = "XML"}},
    {filetype = "lua", name = "Lua"},
  }

  local curr_lang
  local buff_filetype = opts.filetype
  for _, lang in ipairs(languages) do
    if lang.filetype == buff_filetype then
      curr_lang = lang
    end
  end

  local query = _opts.search
  query = query:gsub(" ", "+")

  if curr_lang ~= nil then
    local command = [[/]] .. curr_lang.filetype .. [[/]] .. query
    vim.cmd([[silent! Cheat ]] .. command)
  else
    pickers.new(_opts, {
      finder = finders.new_table {
        results = languages,
        entry_maker = function(entry)
          return {
            value = entry.filetype,
            display = entry.name .. " (" .. entry.filetype .. ")",
            ordinal = entry.name,
            filename = entry.name,
            cmd = entry.filetype,
          }
        end,
      },
      attach_mappings = function(prompt_bufnr)
          action_set.select:replace(function()
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            local command = [[/]] .. entry.cmd .. [[/]] .. query
            vim.cmd([[silent! Cheat ]] .. command)
          end)
          return true
      end,
    }):find()
  end
end

M.projects = function()
  local opts = vim.deepcopy(no_preview)
  opts.search_dirs = {
    -- '~/w',
    '~/dh',
    '~/go/src/github.com/deliveryhero',
    '~/go/src/github.com/pedidosya',
  }
  opts.prompt_title = "Projects"
  opts.find_command = { "fd", "--type", "d", "-d", "1" }
  opts.attach_mappings = function(prompt_bufnr)
    action_set.select:replace(function()
      local entry = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      local dir = from_entry.path(entry)
      vim.fn.execute("cd " .. dir, "silent")
      vim.schedule(function()
        M.git_files()
      end)
    end)
    return true
  end
  require'telescope.builtin'.find_files(opts)
end

M.git_files = function()
  local opts = vim.deepcopy(no_preview)
  opts.prompt_title = "Git Files (workspace)"
  require'telescope.builtin'.git_files(opts)
end

M.project_find = function()
  local opts = vim.deepcopy(no_preview)
  opts.prompt_title = "Project Find (cwd)"
  require'telescope.builtin'.find_files(opts)
end

M.project_grep = function()
  local opts = vim.deepcopy(with_preview)
  opts.search = vim.fn.input("Grep For > ", "")
  if opts.search == "" then
    return
  end
  require'telescope.builtin'.grep_string(opts)
end

M.project_live_grep = function()
  local opts = vim.deepcopy(with_preview)
  require'telescope.builtin'.live_grep(opts)
end

M.buffers = function()
  local opts = vim.deepcopy(no_preview)
  require'telescope.builtin'.buffers(opts)
end

M.buffer_find = function()
  local opts = vim.deepcopy(with_preview)
  opts.prompt_title = "Find in (" .. vim.fn.expand('%:t') ..")"
  require'telescope.builtin'.current_buffer_fuzzy_find(opts)
end

M.command_history = function()
  local opts = vim.deepcopy(no_preview)
  require'telescope.builtin'.command_history(opts)
end

M.project_word = function()
  local opts = vim.deepcopy(with_preview)
  opts.search = vim.fn.expand("<cword>")
  require'telescope.builtin'.grep_string(opts)
end

M.find_symbol = function ()
  local opts = vim.deepcopy(with_preview)
  opts.query = vim.fn.expand("<cword>")
  require'telescope.builtin'.lsp_workspace_symbols(opts)
end

M.quickfix = function()
  local opts = vim.deepcopy(with_preview)
  require'telescope.builtin'.quickfix(opts)
end

M.help_tags = function()
  local opts = vim.deepcopy(no_preview)
  require'telescope.builtin'.help_tags(opts)
end

M.buffer_diagnostics = function()
  local opts = vim.deepcopy(no_preview)
  opts.layout_config = { width = 0.9  }
  opts.prompt_title = 'Diagnostics'
  vim.lsp.diagnostic.set_loclist()
  require('telescope.builtin').loclist(opts)
end

M.lsp_definitions = function()
  local opts = vim.deepcopy(with_preview)
  require('telescope.builtin').lsp_definitions(opts)
end

M.lsp_implementations = function()
  local opts = vim.deepcopy(with_preview)
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
    if not result then
      return
    end

    local bufnr = ctx.bufnr
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local new_result

    -- In go code, I do not like to see any mocks for impls
    if ft == "go" then
      new_result = vim.tbl_filter(function(v)
        return not string.find(v.uri, "mock")
      end, result)
    end

    if #new_result > 1 then
      local flattened_results = {}
      if result then
        vim.list_extend(flattened_results, result)
      end

      local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
      local locations = vim.lsp.util.locations_to_items(flattened_results, offset_encoding)
      pickers.new(opts, {
        prompt_title = 'Implementations',
        finder = finders.new_table {
          results = locations,
          entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
        },
        previewer = conf.qflist_previewer(opts),
        sorter = conf.generic_sorter(opts),
      }):find()
    elseif #new_result == 1 then
      result = new_result
      vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
      vim.cmd [[normal! zz]]
    end
  end)
end

M.lsp_type_definitions = function()
  local opts = vim.deepcopy(with_preview)
  opts.prompt_title = 'Type Definitions'
  require('telescope.builtin').lsp_type_definitions(opts)
end

M.lsp_references = function()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }

  vim.lsp.buf_request(0, "textDocument/references", params, function(err, result, ctx, config)
    if not result then
      return
    end

    -- without current line reference
    local filtered_results = {}
    filtered_results = vim.tbl_filter(function(v)
      local aux = v.range.start.line
      return lnum ~= aux + 1
      -- return true
    end, result)

    if vim.tbl_isempty(filtered_results) then
      return
    end

    if err then
      vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
      return
    end

    local locations = vim.lsp.util.locations_to_items(filtered_results, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)

    if #locations == 1 then
      vim.lsp.handlers["textDocument/references"](err, filtered_results, ctx, config)
      vim.schedule(function()
        vim.cmd [[cfirst]]
        vim.cmd [[cclose]]
        vim.cmd [[normal! zz]]
      end)
    else
      local opts = vim.deepcopy(with_preview)
      pickers.new(opts, {
        prompt_title = "LSP References",
        finder = finders.new_table {
          results = locations,
          entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
        },
        previewer = conf.qflist_previewer(opts),
        sorter = conf.generic_sorter(opts),
      }):find()
    end
  end)
end

return M
