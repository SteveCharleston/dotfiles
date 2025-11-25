return {
    {
        "nvim-treesitter/nvim-treesitter",
        disable = true,
        lazy = false,
        branch = "main",
        build = {
            ":TSUpdate",
            ":TSInstall awk bash c cpp css csv dap_repl diff dockerfile editorconfig git_config git_rebase gitattributes gitcommit gitignore go gomod html java javascript jinja jinja_inline jq json latex lua make markdown markdown_inline matlab nix pascal perl php python ruby rust sql ssh_config strace tcl terraform tmux toml vim vimdoc xml yaml"
        },
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = { enable = true },
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000 ,
        --config = true,
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = true,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            dim_inactive = false,
            transparent_mode = false,
            overrides = {
                DiffAdd = { bg = "#3a431a", fg = "#ebdbb2" },
            }
        },
    },
    "sainnhe/everforest",
    "loctvl842/monokai-pro.nvim",
}
