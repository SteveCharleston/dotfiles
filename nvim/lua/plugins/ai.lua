return {
    {
        "zbirenbaum/copilot.lua",
        -- event = "InsertEnter",
        lazy = false,
        dependencies = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
        },
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<tab>",
                    accept_word = "<M-C-N>",
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    open = "<M-CR>",
                    refresh = "gr",
                    focus = "gf",
                },
            },
            filetypes = {
                ["*"] = true,
            },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        -- build = "make tiktoken",
    },
}
