return {
    "artur-shaik/vim-javacomplete2",
    "wellle/targets.vim",
    "vim-scripts/repeat.vim",
    "inkarkat/vcscommand.vim",
    "paranoida/vim-airlineish",
    "hsanson/vim-android",
    "tmatilai/vim-monit",
    "tpope/vim-dispatch",
    "justinmk/vim-gtfo",
    "justinmk/vim-syntax-extra",
    "4Evergreen4/vim-hardy",
    "joshdick/onedark.vim",
    "tpope/vim-speeddating",
    "cosminadrianpopescu/filesync",
    "vim-scripts/tcd.vim",
    "thinca/vim-visualstar",
    "junegunn/vim-journal",
    "cespare/vim-toml",
    "aklt/plantuml-syntax",
    "cohama/lexima.vim",
    {
        "sontungexpt/url-open",
        branch = "mini",
        event = "VeryLazy",
        cmd = "URLOpenUnderCursor",
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then
                return
            end
            url_open.setup ({})
        end,
        keys = {
            { "gx", "<cmd>URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
        },
    },
    -- {
    --     "vim-scripts/surround.vim",
    --     dependencies = "tpope/vim-repeat",
    -- },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "inkarkat/vim-SpellCheck",
        dependencies = "inkarkat/vim-ingo-library"
    },
    {
        "simnalamburt/vim-mundo",
        cmd = "MundoToggle"
    },
    {
        "tpope/vim-markdown",
        commit = "baf2592d33d6d73bf2bcb7cf3251586eed5148f9"
    },
    {
        "derekwyatt/vim-fswitch",
        keys = {
            { "<C-7>", "<cmd>FSHere<cr>", desc = "Switch header and implementation" },
        },
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle"
    },
    {
        'luochen1990/rainbow',
        cmd = "RainbowToggle",
        init = function()
            vim.g.rainbow_active = 0
        end,
    },
    {
        "Lokaltog/vim-easymotion",
        init = function()
            vim.g.EasyMotion_keys = "abcdefghijklmnopqrstuvwxyz"
            vim.g.EasyMotion_use_upper = 1
            vim.g.EasyMotion_add_search_history = 0
        end,
        keys = {
            { "<Leader>w", "<Plug>(easymotion-bd-f)", desc = "Easymotion Bidirectional Forward" },
            { "<C-j>", "<Plug>(easymotion-sn)", desc = "Easymotion Search Next" },
        },

    },
    {
        "ripxorip/aerojump.nvim",
        build = ":UpdateRemotePlugins",
    },
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = {"n", "x"}, desc = "Easy Align" },
        },
    },
    {
        "dominikduda/vim_current_word",
        init = function()
            vim.cmd([[
                " Twins of word under cursor:
                let g:vim_current_word#highlight_twins = 1
                " The word under cursor:
                let g:vim_current_word#highlight_current_word = 1
                " highlight current word
            ]])
        end,
    },
    {
        "epeli/slimux",
        keys = {
            { "<C-c><C-c>", "<cmd>SlimuxREPLSendLine<cr>", desc = "Slimux Send Line" },
            { "<C-c><C-c>", "<cmd>SlimuxREPLSendSelection<cr>", mode = "v", desc = "Slimux Send Selection" },
        },
    },
    {
        "saltstack/salt-vim",
        ft = "sls",
        init = function()
            vim.g.sls_use_jinja_syntax = 1
        end,
    },
    {
        "t9md/vim-quickhl",

        keys = {
            { "<leader>v", "<Plug>(quickhl-manual-this)", mode={"x", "n"}, desc = "Quickhl Highlight Word" },
            { "<leader>V", "<Plug>(quickhl-manual-reset)", mode={"x", "n"}, desc = "Quickhl Reset Highlights" },
        },
    },
    {
        "mileszs/ack.vim",
        init = function()
            if vim.fn.executable('ag') == 1 then
                vim.g.ackprg = 'ag --nogroup --nocolor --column'
                vim.g.ack_use_dispatch = 1
            end
        end,
    },
    {
        "dyng/ctrlsf.vim",
        init = function()
            vim.cmd([[
                cnoreabbrev CS CtrlSF
            ]])
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
            });
        end
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        opts = {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    { desc = '  New File', group = '@function', action = 'ene!', key = 'n' },
                    { desc = '  Find File', group = '@property', action = 'FzfLua files', key = 'f' },
                    { desc = '  Recent Files', group = '@method', action = 'FzfLua oldfiles', key = 'r' },
                    { desc = '  Find Text', group = '@type', action = 'FzfLua live_grep', key = 't' },
                    { desc = '  Bookmarks', group = '@constant', action = 'FzfLua marks', key = 'b' },
                    { desc = '  Load Session', group = '@keyword', action = 'SessionLoad', key = 's' },
                    { desc = '  Quit NVIM', group = '@function', action = 'qa', key = 'q' },
                },
            },
        },
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },
    {
        "Owen-Dechow/videre.nvim",
        cmd = "Videre",
        dependencies = {
            "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
            "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
            "a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
        },
        opts = {
            round_units = false,
            simple_statusline = false, -- If you are just starting out with Videre,
            --   setting this to `false` will give you
            --   descriptions of available keymaps.
        }
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {

        },
    },
}
