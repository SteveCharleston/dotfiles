return {
    {
        "bling/vim-airline",
        enabled = true,
        dependencies = { "vim-airline/vim-airline-themes", "liuchengxu/vista.vim" },
        init = function()

            vim.g.airline_theme = "deus"
            vim.g.airline_powerline_fonts = 1
            vim.o.laststatus = 3
            vim.cmd([[
                if !exists('g:airline_symbols')
                    let g:airline_symbols = {}
                endif
                " unicode symbols
                let g:airline_left_sep = ''
                let g:airline_right_sep = ''
                let g:airline_symbols.branch = ''
                let g:airline_symbols.linenr = '#'
                let g:airline_symbols.paste = '∥'
                let g:airline_symbols.whitespace = 'Ξ'
                let g:airline_symbols.dirty=' '
                let g:airline#extensions#coc#enabled = 1

                let g:airline_section_z  = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%1l%#__restore__#%#__accent_bold#/%L%#__restore__#:%2v'

                " make everything smaller
                " Disable error and warning line numbers
                let g:airline#extensions#ale#enabled = 0
                let airline#extensions#nvimlsp#show_line_numbers = 0
                " nvimlsp error_symbol >
                let airline#extensions#nvimlsp#error_symbol = '󰅚 '
                " nvimlsp warning >
                let airline#extensions#nvimlsp#warning_symbol = '󰀪 '
                let g:airline#extensions#whitespace#enabled = 0

                " don't display fileformat if it is an unix file
                let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
            ]])

        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        enabled = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        init = function()
            vim.o.laststatus = 3
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'gruvbox',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                        refresh_time = 16, -- ~60fps
                        events = {
                            'WinEnter',
                            'BufEnter',
                            'BufWritePost',
                            'SessionLoadPost',
                            'FileChangedShellPost',
                            'VimResized',
                            'Filetype',
                            'CursorMoved',
                            'CursorMovedI',
                            'ModeChanged',
                        },
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diagnostics'},
                    lualine_c = {{'filename', file_status = true, path = 1}, 'modified', {
                        '%r',
                        cond = function()
                            return vim.bo.readonly
                        end,
                    }},
                    lualine_x = {
                        {
                            'lsp_status',
                            icon = '', -- f013
                            symbols = {
                                -- Standard unicode symbols to cycle through for LSP progress:
                                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                                -- Standard unicode symbol for when LSP is done:
                                done = '✓',
                                -- Delimiter inserted between LSP names:
                                separator = ' ',
                            },
                            -- List of LSP names to ignore (e.g., `null-ls`):
                            ignore_lsp = {},
                            -- Display the LSP name
                            show_name = true,
                        }, 'encoding', 'fileformat', 'filetype'},
                        lualine_y = {'%p%%/%L'},
                        lualine_z = {'location', 'searchcount', 'search_result'}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {'filename'},
                        lualine_x = {'location'},
                        lualine_y = {},
                        lualine_z = {}
                    },
                    tabline = {},
                    winbar = {},
                    inactive_winbar = {},
                    extensions = {
                        'quickfix',
                        'fugitive',
                        'nerdtree',
                        'fzf',
                        'man',
                        'symbols-outline',
                        'trouble',
                    }
                }
        end,
    },
}
