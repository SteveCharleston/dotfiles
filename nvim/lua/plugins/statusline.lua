return {
    {
        "bling/vim-airline",
        dependencies = { "vim-airline/vim-airline-themes", "liuchengxu/vista.vim" },
        init = function()

            vim.g.airline_theme = "dark"
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
                let g:airline#extensions#ale#enabled = 1
                let airline#extensions#ale#show_line_numbers = 0
                " ale error_symbol >
                let airline#extensions#ale#error_symbol = 'E'
                " ale warning >
                let airline#extensions#ale#warning_symbol = 'W'
                let g:airline#extensions#whitespace#enabled = 0

                " don't display fileformat if it is an unix file
                let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
            ]])

        end,
    }
}
