return {
    {
        "scrooloose/nerdtree",
        init = function()
            vim.g.NERDTreeShowHidden = 1
            vim.g.NERDTreeMinimalUI = 1
            vim.g.NERDTreeChDirMode = 2
            vim.g.NERDTreeShowBookmarks = 2
            vim.g.NERDTreeMinimalUI = 1
            vim.g.NERDTreeHijackNetrw = 0
            vim.g.NERDTreeDirArrows = 0
            vim.g.NERDTreeCascadeSingleChildDir = 0
            vim.g.NERDTreeDirArrowExpandable = '▸'
            vim.g.NERDTreeDirArrowCollapsible = '▾'
            vim.cmd([[
                " Exit Vim if NERDTree is the only window remaining in the only tab.
                autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
            ]])
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "antosha417/nvim-lsp-file-operations",
        },
        lazy = false, -- neo-tree will lazily load itself
        opts = {
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
            hide_root_node = true, -- Hide the root node.

            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_ignored = false,
                    hide_hidden = false,
                    hide_by_name = {
                        "node_modules",
                        ".DS_Store",
                    },
                hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
                },
                follow_current_file = {
                    enabled = false,
                },
                use_libuv_file_watcher = true,
            },
            source_selector = {
                winbar = true,
                statusline = false,
            },
        },
    }
}
