return {
    {
        "zbirenbaum/copilot.lua",
        -- event = "InsertEnter",
        lazy = false,
        dependencies = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
        },
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<tab>",
                    accept_word = "<M-C-N>",
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    open = "<M-CR>",
                    refresh = "gr",
                    focus = "gf",
                },
            },
            filetypes = {
                ["*"] = true,
            },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        -- build = "make tiktoken",
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        opts = {
            adapters = {
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend("claude_code", {})
                    end,
                },
            },
            interactions = {
                chat = {
                    --adapter = {
                    --    name = "anthropic",
                    --    model = "claude-sonnet-5"
                    --},
                    adapter = "anthropic",
                    model = "claude-sonnet-5",
                    --adapter = "claude_code",
                },
                inline = {
                    adapter = {
                        name = "anthropic",
                        model = "claude-sonnet-5"
                    },
                },
                cli = {
                    agent = "claude_code",
                    agents = {
                        claude_code = {
                            cmd = "claude",
                            args = {},
                            description = "Claude Code CLI",
                            provider = "terminal",
                        },
                    },
                },
                background = {
                    chat = {
                        callbacks = {
                            ["on_ready"] = {
                                actions = {
                                    "interactions.background.builtin.chat_make_title",
                                },
                                -- Enable "on_ready" callback which contains the title generation action
                                enabled = true,
                            },
                        },
                        opts = {
                            -- Enable background interactions generally
                            enabled = true,
                        },
                    },
                },
            },
            display = {
                chat = {
                    show_reasoning = true,
                    show_token_count = true,
                    show_settings = true,
                    window = {
                        pertab = false,
                        layout = "vertical",
                        position = "right",
                        width = 0.4,
                    },
                },
                action_palette = {
                    width = 95,
                    height = 10,
                    prompt = "Prompt ", -- Prompt used for interactive LLM calls
                    provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                    opts = {
                        show_preset_actions = true, -- Show the preset actions in the action palette?
                        show_preset_prompts = true, -- Show the preset prompts in the action palette?
                        title = "CodeCompanion actions", -- The title of the action palette
                    },
                },
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true
                    }
                }
            }
        },
    },
    {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            -- add any opts here
            -- this file can contain specific instructions for your project
            instructions_file = "avante.md",
            -- for example
            provider = "claude",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-5",
                    timeout = 30000,
                    request_body = {
                        max_tokens = 20480,
                        temperature = 0,
                    },
                },
            }
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
        },
    }
}
