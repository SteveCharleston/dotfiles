return {
    -- svn and git integration
    {
        "juneedahamed/vc.vim",
        init = function()
            vim.g.no_vc_maps = 1
        end
    },

    -- git integration
    {
        "tpope/vim-fugitive",
        init = function()
            vim.cmd([[
                autocmd FileType git set foldmethod=syntax
                autocmd FileType fugitive nnoremap <buffer> q :<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>
            ]])
        end,
    },

    -- commit browser
    {
        "junegunn/gv.vim",
        dependencies = "tpope/vim-fugitive"
    },

    -- Branch browser
    {"idanarye/vim-merginal"},
    {
        "sodapopcan/vim-twiggy", -- Better branch browser
        dependencies = "tpope/vim-fugitive"
    },

    -- inline git commit messages
    {
        "rhysd/git-messenger.vim",
        keys = {
            { "<C-w>m", "<Plug>(git-messenger)", desc = "Git Messenger" },
        },
        init = function()
            vim.g.git_messenger_no_default_mappings = 1
        end,
    },

    -- worse commit browser
    {"gregsexton/gitv", cmd = "Gitv"},

    -- diff viewer
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim"
        }
    },

    -- GitLab integration
    {
        "shumphrey/fugitive-gitlab.vim",
        dependencies = "tpope/vim-fugitive",
        init = function()
            vim.cmd([[
                if filereadable(expand("~/.gitlab_credentials"))
                    source ~/.gitlab_credentials
                endif
                if exists("$GITLAB_TOKEN")
                    let g:fugitive_gitlab_token = $GITLAB_TOKEN
                endif
            ]])
        end,
    },

    -- GitHub integration
    {
        "tpope/vim-rhubarb",
        dependencies = "tpope/vim-fugitive",
    }
}
