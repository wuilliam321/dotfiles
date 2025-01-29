return {
  {
    'tzachar/cmp-tabnine',
    build = './install.sh'
  },
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_filetypes = { VimspectorPrompt = false }
    end,
  },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          ollama = {
            disable = false,
            endpoint = "http://localhost:11434/v1/chat/completions",
            secret = "dummy_secret",
          },

        },
        agents = {
          {
            provider = "ollama",
            name = "Codellama-7B-code",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = "codellama:7b-code",
              temperature = 0.2,
              top_p = 1,
              min_p = 0.05,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a AI code assistant.",
          },
          {
            provider = "ollama",
            name = "ChatOllamaLlama3.1-8B",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = {
              model = "llama3.2:3b",
              temperature = 0.2,
              top_p = 1,
              min_p = 0.05,
            },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a golang AI assistant.",
          },
        }
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
}
