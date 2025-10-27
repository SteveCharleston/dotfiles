return {
    {
        "vim-test/vim-test"
    },
    {
        "rcarriga/vim-ultest",
        dependencies = { "vim-test/vim-test" },
        init = function()
            vim.g.ultest_deprecation_notice = 0
            vim.g.ultest_running_sign = ""
        end,
    }
}
