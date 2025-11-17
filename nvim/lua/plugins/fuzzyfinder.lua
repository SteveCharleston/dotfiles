return {
    {
        "Yggdroot/LeaderF",
        init = function()
            vim.g.Lf_ShortcutF = "<C-p>"
            vim.g.Lf_PreviewInPopup = 1
            vim.g.Lf_WindowPosition = "popup"
            vim.g.Lf_StlColorscheme = "gruvbox_material"
            vim.g.Lf_PopupPreviewPosition = "right"
            vim.g.Lf_PopupBorders = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}

            vim.g.Lf_PreviewResult = {
                 File = 1,
                 Buffer = 1,
                 Mru = 1,
                 Tag = 0,
                 BufTag = 1,
                 Function = 1,
                 Line = 1,
                 Colorscheme = 0,
                 Rg = 0,
                 Gtags = 0
                }
        end,
        keys = {
            -- { "<C-p>", "<cmd>LeaderfFile<cr>", desc = "LeaderF Buffer Tags" },
            { "<Leader>f", "<cmd>LeaderfBufTag<cr>", desc = "LeaderF Buffer Tags" },
            -- { "<Leader>l", "<cmd>LeaderfLine<cr>", desc = "LeaderF Lines" },
            -- { "<Leader>t", "<cmd>LeaderfTag<cr>", desc = "LeaderF Tags" },
            { "<Leader>m", "<cmd>LeaderfMru<cr>", desc = "LeaderF MRU" },
        },
        build = ":LeaderfInstallCExtension",
    },

    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("fzf-lua").setup(
            {
            winopts = {
                backdrop = 100,
                width = 0.9,
            },
            keymap = {
                builtin = {
                    ["<c-u>"] = "preview-page-up",
                    ["<c-d>"] = "preview-page-down",
                },
            },
            defaults = {
                formatter    = "path.dirname_first",
            },
            files = {
                git_icons = true,
                file_icons = true,
                color_icons = true,
                cwd_header = true,
                cwd_prompt = false,
                actions = {
                    ["default"] = require("fzf-lua.actions").file_edit, -- directly populate buffer list instead of quickfix
                },
            },
            lsp = {
                symbols = {
                    child_prefix = "➜ ",
                    locate = false,
                },
            }
        })
        end,
        keys = {
            { "<Leader>g", "<cmd>FzfLua buffers<cr>", desc = "FZF Lua Buffers" },
            { "<C-p>", "<cmd>FzfLua files<cr>", desc = "FZF Lua file search" },
            { "<Leader>l", "<cmd>FzfLua blines<cr>", desc = "FZF Lua Lines" },
        },
    },
    -- {
    --     "junegunn/fzf.vim",
    --     lazy = false,
    --     name = "fzf",
    --     dependencies = {"junegunn/fzf", lazy = false},
    --     keys = {
    --         { "<Leader>g", "<cmd>Buffers<cr>", desc = "FZF Buffers" },
    --     },
    --     dir = "~/.fzf",
    --     build = "./install --all"
    -- }
}
