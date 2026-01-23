return {
    -- {
    --   "ravitemer/mcphub.nvim",
    --   dependencies = {
    --     "nvim-lua/plenary.nvim",
    --   },
    --   build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    --   opts = {
    --     extensions = {
    --       avante = {
    --         make_slash_commands = true, -- make /slash commands from MCP server prompts
    --       }
    --     },
    --     -- auto_approve = true,
    --   }
    -- },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "meli",
            auto_suggestions_provider = "meli",
            cursor_applying_provider = "meli",
            providers = {
                ---@type AvanteProvider
                meli = {
                    __inherited_from = 'openai',
                    endpoint = "https://genai.melioffice.com/proxy/openai/v1",
                    api_key_name = "MELI_API_KEY",
                    model = "gpt-5",
                    extra_request_body = {
                        temperature = 1,
                        max_completion_tokens = 20480,
                        stream_options = {
                            include_obfuscation = false,
                        },
                    },
                }
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            -- "zbirenbaum/copilot.lua",        -- for providers='copilot'
            -- {
            --   -- support for image pasting
            --   "HakonHarnes/img-clip.nvim",
            --   event = "VeryLazy",
            --   opts = {
            --     -- recommended settings
            --     default = {
            --       embed_image_as_base64 = false,
            --       prompt_for_file_name = true,
            --       drag_and_drop = {
            --         insert_mode = true,
            --       },
            --       -- required for Windows users
            --       use_absolute_path = true,
            --     },
            --   },
            -- },
            -- {
            --   -- Make sure to set this up properly if you have lazy=true
            --   'MeanderingProgrammer/render-markdown.nvim',
            --   opts = {
            --     file_types = { "markdown", "Avante" },
            --   },
            --   ft = { "markdown", "Avante" },
            -- },
        },
    },
    {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = { VimspectorPrompt = false }
        end,
    },
}
