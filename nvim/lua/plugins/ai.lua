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
            "ravitemer/codecompanion-history.nvim",
            "lalitmee/codecompanion-spinners.nvim",
            'mrjones2014/codecompanion-ui.nvim',
            --"franco-ruggeri/codecompanion-spinner.nvim",
        },
        opts = {
            adapters = {
                http = {
                    -- Route the built-in "anthropic" adapter through the litellm proxy.
                    -- Requires ANTHROPIC_BASE_URL and ANTHROPIC_AUTH_TOKEN in the environment.
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "ANTHROPIC_AUTH_TOKEN",
                                base_url = "ANTHROPIC_BASE_URL",
                            },
                            url = "${base_url}/v1/messages",
                            schema = {
                                model = {
                                    default = "claude-sonnet-5",
                                    -- The built-in adapter's `choices` fetches from the
                                    -- hardcoded https://api.anthropic.com/v1/models, which
                                    -- bypasses our proxy override and fails auth. Replace it
                                    -- with a static list instead.
                                    choices = {
                                        "claude-sonnet-5",
                                        "claude-opus-4-1",
                                    },
                                },
                            },
                        })
                    end,
                },
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
                    tools = {
                        -- Read-only/low-risk tools: skip the approval prompt
                        -- entirely, even outside yolo mode.
                        read_file = {
                            opts = {
                                require_approval_before = false,
                            },
                        },
                        grep_search = {
                            opts = {
                                require_approval_before = false,
                            },
                        },
                        memory = {
                            opts = {
                                require_approval_before = false,
                            },
                        },
                        -- These two tools opt out of yolo mode and the background
                        -- judge by default (config.lua: judge_in_yolo_mode = false).
                        -- Re-enable the judge so yolo mode doesn't always fall back
                        -- to a manual prompt; allowed_in_yolo_mode stays false so
                        -- only a safe verdict from the judge grants execution.
                        run_command = {
                            opts = {
                                judge_in_yolo_mode = true,
                                -- Skip the approval prompt entirely (in any mode) for a
                                -- small allowlist of read-only commands. Anything with
                                -- shell metacharacters (chaining, substitution,
                                -- redirection) still requires approval, even if it
                                -- starts with an allowed program, e.g. `ls; rm -rf ~`.
                                require_approval_before = function(tool)
                                    local cmd = tool.args and tool.args.cmd
                                    if not cmd or cmd == "" then
                                        return true
                                    end
                                    if cmd:match("[;&|`$<>\n]") then
                                        return true
                                    end

                                    local parts = vim.split(vim.trim(cmd), "%s+", { trimempty = true })
                                    if #parts == 0 then
                                        return true
                                    end

                                    local program = vim.fn.fnamemodify(parts[1], ":t")
                                    local allowed_programs = {
                                        ls = true,
                                        pwd = true,
                                        cat = true,
                                        find = true,
                                        grep = true,
                                        rg = true,
                                    }
                                    if allowed_programs[program] then
                                        return false
                                    end

                                    if program == "git" and parts[2] then
                                        local allowed_git_subcommands = {
                                            status = true,
                                            diff = true,
                                            log = true,
                                        }
                                        if allowed_git_subcommands[parts[2]] then
                                            return false
                                        end
                                    end

                                    return true
                                end,
                            },
                        },
                        delete_file = {
                            opts = {
                                judge_in_yolo_mode = true,
                            },
                        },
                    },
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
                    -- Route the background judge (used for yolo-mode tool
                    -- auto-approval) through the same litellm-proxied anthropic
                    -- adapter instead of the default "copilot", so it shares
                    -- auth/config with chat.
                    adapter = "anthropic",
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
                },
                history = {
                    enabled = true,
                    opts = {
                        -- Default keymap to open history from chat buffer
                        keymap = "gh",
                        -- Automatically generate titles for new conversations
                        auto_generate_title = true,
                        continue_last_chat = false,
                        delete_on_clearing_chat = false,
                        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                        enable_logging = false,
                        picker = "default", -- "telescope", "snacks", "fzf-lua" or "default"
                        summary = {
                            create_summary_keymap = "gS", -- Keymap to create summary for a conversation
                        },
                    }
                },
                spinner = {
                    opts = {
                        -- Default spinner style
                        style = "native",
                    },
                },
                ui = {
                    enabled = false,
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
