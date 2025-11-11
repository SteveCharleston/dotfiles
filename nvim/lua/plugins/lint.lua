return {
    {
        "w0rp/ale",
        lazy = false,
        init = function()
            vim.g.ale_fixers = {
                python = { "black", "isort" },
                rust = { "rustfmt" },
            }
            vim.g.ale_lint_on_text_changed = "always"
            vim.g.ale_set_loclist = 1
            vim.g.ale_set_quickfix = 0
            vim.g.ale_set_highlights = 1
            vim.g.ale_set_signs = 1
            vim.g.ale_set_balloons = 1
            vim.g.ale_sign_error = ''
            vim.g.ale_sign_warning = ''
            vim.g.ale_virtualtext_cursor = 1
            vim.g.ale_python_mypy_options = '--ignore-missing-imports'
            vim.g.ale_use_neovim_diagnostics_api = 1
            vim.g.ale_virtualtext_cursor = 0

            vim.g.ale_linter_aliases = {
                sls = 'salt'
            }
            vim.g.ale_linters = {
                python = { 'mypy', 'pylint', 'flake8', 'pydocstyle', 'bandit' }
            }
            vim.g.ale_python_bandit_options = "--skip B101"
            vim.g.ale_rust_cargo_use_clippy = vim.fn.executable('cargo-clippy') == 1

            vim.cmd([[
                sign define DiagnosticSignError text= texthl=DiagnosticSignError
                sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
                sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
                sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
            ]])
        end,

        config = function()
            vim.diagnostic.config({
                -- virtual_lines = {
                --     current_line = true
                -- }
            })
        end,
        keys = {
            -- Show diagnostics in a floating window
            {
                "<leader>e",
                function()
                    vim.diagnostic.open_float({ scope = "line" })
                end,
                desc = "Open diagnostics float",
            },
            {"<leader>[", "<cmd>ALEPrevious<cr>", desc = "Go to previous ALE diagnostic"},
            {"<leader>]", "<cmd>ALENext<cr>", desc = "Go to next ALE diagnostic"},
            {"<leader>=", "<cmd>ALEFix<cr>", desc = "Fix code issues"}
        },
    },

    -- {
    --     "luozhiya/lsp-virtual-improved.nvim",
    --     config = function()
    --         require('lsp-virtual-improved').setup()
    --         vim.diagnostic.config {
    --             underline = true,
    --                 virtual_text = false,
    --                 virtual_improved = {
    --                     current_line = 'only',
    --                     spacing = 1,
    --                     prefix = '■', -- Same usage as virtual_text.prefix
    --                 },
    --                 float = {
    --                     show_header = true,
    --                     source = 'if_many',
    --                     border = 'rounded',
    --                     focusable = false,
    --                 },
    --                 signs = true,
    --                 severity_sort = true,
    --                 update_in_insert = true,

    --             }
    --     end,
    -- },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        init = function()
            vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
        end,
        opts = {
            -- Choose a preset style for diagnostic appearance
            -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
            preset = "powerline",

            -- Make diagnostic background transparent
            transparent_bg = false,

            -- Make cursorline background transparent for diagnostics
            transparent_cursorline = false,

            -- Customize highlight groups for colors
            -- Use Neovim highlight group names or hex colors like "#RRGGBB"
            hi = {
                error = "DiagnosticError",     -- Highlight for error diagnostics
                warn = "DiagnosticWarn",       -- Highlight for warning diagnostics
                info = "DiagnosticInfo",       -- Highlight for info diagnostics
                hint = "DiagnosticHint",       -- Highlight for hint diagnostics
                arrow = "DiagnosticSignWarn",  -- Highlight for the arrow pointing to diagnostic
                background = "Normal",     -- Background highlight for diagnostics
                mixing_color = "Normal",       -- Color to blend background with (or "None")
            },

            -- List of filetypes to disable the plugin for
            disabled_ft = {},

            options = {
                -- Display the source of diagnostics (e.g., "lua_ls", "pyright")
                show_source = {
                    enabled = true,           -- Enable showing source names
                    if_many = false,           -- Only show source if multiple sources exist for the same diagnostic
                },

                -- Use icons from vim.diagnostic.config instead of preset icons
                use_icons_from_diagnostic = false,

                -- Color the arrow to match the severity of the first diagnostic
                set_arrow_to_diag_color = true,


                -- Throttle update frequency in milliseconds to improve performance
                -- Higher values reduce CPU usage but may feel less responsive
                -- Set to 0 for immediate updates (may cause lag on slow systems)
                throttle = 20,

                -- Minimum number of characters before wrapping long messages
                softwrap = 30,

                -- Control how diagnostic messages are displayed
                -- NOTE: When using display_count = true, you need to enable multiline diagnostics with multilines.enabled = true
                --       If you want them to always be displayed, you can also set multilines.always_show = true.
                add_messages = {
                    messages = true,           -- Show full diagnostic messages
                    display_count = false,     -- Show diagnostic count instead of messages when cursor not on line
                    use_max_severity = false,  -- When counting, only show the most severe diagnostic
                    show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
                },

                -- Settings for multiline diagnostics
                multilines = {
                    enabled = false,           -- Enable support for multiline diagnostic messages
                    always_show = false,       -- Always show messages on all lines of multiline diagnostics
                    trim_whitespaces = false,  -- Remove leading/trailing whitespace from each line
                    tabstop = 4,               -- Number of spaces per tab when expanding tabs
                    severity = nil,            -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
                },

                -- Show all diagnostics on the current cursor line, not just those under the cursor
                show_all_diags_on_cursorline = true,

                -- Display related diagnostics from LSP relatedInformation
                show_related = {
                    enabled = true,           -- Enable displaying related diagnostics
                    max_count = 3,             -- Maximum number of related diagnostics to show per diagnostic
                },

                -- Enable diagnostics display in insert mode
                -- May cause visual artifacts; consider setting throttle to 0 if enabled
                enable_on_insert = false,

                -- Enable diagnostics display in select mode (e.g., during auto-completion)
                enable_on_select = false,

                -- Handle messages that exceed the window width
                overflow = {
                    mode = "wrap",             -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
                    padding = 0,               -- Extra characters to trigger wrapping earlier
                },

                -- Break long messages into separate lines
                break_line = {
                    enabled = false,           -- Enable automatic line breaking
                    after = 30,                -- Number of characters before inserting a line break
                },

                -- Custom function to format diagnostic messages
                -- Receives diagnostic object, returns formatted string
                -- Example: function(diag) return diag.message .. " [" .. diag.source .. "]" end
                format = nil,

                -- Virtual text display priority
                -- Higher values appear above other plugins (e.g., GitBlame)
                virt_texts = {
                    priority = 2048,
                },

                -- Filter diagnostics by severity levels
                -- Remove severities you don't want to display
                severity = {
                    vim.diagnostic.severity.ERROR,
                    vim.diagnostic.severity.WARN,
                    vim.diagnostic.severity.INFO,
                    vim.diagnostic.severity.HINT,
                },

                -- Events that trigger attaching diagnostics to buffers
                -- Default is {"LspAttach"}; change only if plugin doesn't work with your LSP setup
                overwrite_events = nil,

                -- Automatically disable diagnostics when opening diagnostic float windows
                override_open_float = true,
            },
        }
    },
    {
        "folke/trouble.nvim",
        init = function()
            vim.cmd([[
                highlight! link TroubleNormal Normal
                highlight! link TroubleNormalNC Normal
            ]])
        end,
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
    }
}
