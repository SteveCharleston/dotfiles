return {
    {
        "vim-test/vim-test"
    },
    -- {
    --     "rcarriga/vim-ultest",
    --     dependencies = { "vim-test/vim-test" },
    --     init = function()
    --         vim.g.ultest_deprecation_notice = 0
    --         vim.g.ultest_running_sign = ""
    --     end,
    -- },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            -- "nvim-neotest/neotest-vim-test",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                    require("neotest-plenary"),
                    --require("neotest-vim-test")({
                    --    ignore_file_types = { "python", "vim", "lua" },
                    --}),
                },
            })
        end,
    }
}
