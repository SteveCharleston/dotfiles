return {
    {
        "neoclide/coc.nvim",
        lazy = false,
        branch = "release",
        init = function()
            vim.g.coc_global_extensions = {
                "coc-css",
                "coc-diagnostic",
                "coc-emmet",
                "coc-html",
                "coc-java",
                "coc-json",
                "coc-lists",
                "coc-omni",
                "coc-jedi",
                "coc-sh",
                "coc-snippets",
                "coc-ultisnips",
                "coc-vimtex",
                "coc-yaml",
                "coc-yank",
            }
            vim.cmd([[
                inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#_select_confirm()
                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
                inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#_select_confirm()
                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
                function! s:show_documentation()
                    if (index(['vim','help'], &filetype) >= 0)
                        execute 'h '.expand('<cword>')
                    else
                        call CocAction('doHover')
                    endif
                endfunction
                set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
            ]])
        end,
        keys = {
            --{ "gd", "<Plug>(coc-definition)", desc = "Go to Definition" },
            { "gy", "<Plug>(coc-type-definition)", noremap = true, desc = "Go to Type Definition" },
            { "gi", "<Plug>(coc-implementation)", desc = "Go to Implementation" },
            { "gr", "<Plug>(coc-references)", desc = "Go to References" },
            { "<leader>rn", "<Plug>(coc-rename)", desc = "Rename Symbol" },
            { "<leader>ca", "<Plug>(coc-codeaction)", desc = "Code Action" },
            { "K", "<cmd>call <SID>show_documentation()<CR>", desc = "Show Documentation" },
            { "<leader>=", "<Plug>(coc-format-selected)", mode="x", desc = "Format Selected Code" },
            { "<leader>a", "<Plug>(coc-codeaction-selected)", mode="x", desc = "Code Action Selected" },
            { "<leader>ac", "<Plug>(coc-codeaction)", desc = "Code Action on current line" },
            { "<leader>qf", "<Plug>(coc-fix-current)", desc = "Fix Current Issue on current line" },
        },
    }
}
