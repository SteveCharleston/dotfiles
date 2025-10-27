return {
    "SirVer/ultisnips",
    dependencies = { "SteveCharleston/vim-snippets" },
    init = function()
        vim.g.UltiSnipsExpandOrJumpTrigger = "<c-k>"
        vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
        vim.g.ultisnips_python_style = 'sphinx'
        vim.o.conceallevel = 0
        vim.o.concealcursor = "i"
    end,
}
