return {
    {
        "majutsushi/tagbar",
        init = function()
            vim.g.tagbar_left = 0
            vim.g.tagbar_singleclick = 1
            vim.g.rust_use_custom_ctags_defs = 1
            vim.g.tagbar_type_rust = {
                ctagsbin  = 'ctags',
                ctagstype  = 'rust',
                kinds = {
                    'n:modules',
                    's:structures:1',
                    'i:interfaces',
                    'c:implementations',
                    'f:functions:1',
                    'g:enumerations:1',
                    't:type aliases:1:0',
                    'v:constants:1:0',
                    'M:macros:1',
                    'm:fields:1:0',
                    'e:enum variants:1:0',
                    'P:methods:1',
                },
                sro = '::',
                kind2scope = {
                    n = 'module',
                    s = 'struct',
                    i = 'interface',
                    c = 'implementation',
                    f = 'function',
                    g = 'enum',
                    t = 'typedef',
                    v = 'variable',
                    M = 'macro',
                    m = 'field',
                    e = 'enumerator',
                    P = 'method',
                },
            }
        end,
    },

    {
        "vim-scripts/taglist.vim",
        cmd = "TlistToggle",
        init = function()
            vim.g.Tlist_Auto_Open = 0 -- Do not open taglist automatically
            vim.g.Tlist_Exit_OnlyWindow = 1 -- Exit Vim when taglist is the only window left
            vim.g.Tlist_Use_Right_Window = 1
        end
    },

    {
        "liuchengxu/vista.vim",
        cmd = "Vista"
    },
    {
        'stevearc/aerial.nvim',
        opts = {
            backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
            placement = "window",
            attach_mode = "global",
            filter_kind = {
                "Class",
                "Constructor",
                "Enum",
                "EnumMember",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct",
                "Property",
                "Field",
                "Constant",
            },
            show_guides = true,
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
}
