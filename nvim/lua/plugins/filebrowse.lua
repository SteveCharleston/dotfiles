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
        end,
    }
}
