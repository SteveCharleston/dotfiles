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

            -- let g:ale_linter_aliases = {
            --     \ 'sls': 'salt'
            --     \}

            -- let g:ale_linters = {
            --         \ 'python': [
            --             \ 'mypy',
            --             \ 'pylint',
            --             \ 'flake8',
            --             \ 'pydocstyle',
            --             \ 'bandit',
            --         \ ] }

            -- let g:ale_python_bandit_options = "--skip B101"
            -- let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

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

    {
        "luozhiya/lsp-virtual-improved.nvim",
        config = function()
            require('lsp-virtual-improved').setup()
            vim.diagnostic.config {
                underline = true,
                    virtual_text = false,
                    virtual_improved = {
                        current_line = 'only',
                        spacing = 1,
                        prefix = '■', -- Same usage as virtual_text.prefix
                    },
                    float = {
                        show_header = true,
                        source = 'if_many',
                        border = 'rounded',
                        focusable = false,
                    },
                    signs = true,
                    severity_sort = true,
                    update_in_insert = true,

                }
        end,
    }
}
