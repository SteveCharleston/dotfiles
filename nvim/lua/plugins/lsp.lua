return {
    -- {
    --     "neoclide/coc.nvim",
    --     lazy = false,
    --     branch = "release",
    --     init = function()
    --         vim.g.coc_global_extensions = {
    --             "coc-css",
    --             "coc-diagnostic",
    --             "coc-emmet",
    --             "coc-html",
    --             "coc-java",
    --             "coc-json",
    --             "coc-lists",
    --             "coc-omni",
    --             "coc-jedi",
    --             "coc-sh",
    --             "coc-snippets",
    --             "coc-ultisnips",
    --             "coc-vimtex",
    --             "coc-yaml",
    --             "coc-yank",
    --         }
    --         vim.cmd([[
    --             inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#_select_confirm()
    --                 \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    --             inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#_select_confirm()
    --                 \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    --             function! s:show_documentation()
    --                 if (index(['vim','help'], &filetype) >= 0)
    --                     execute 'h '.expand('<cword>')
    --                 else
    --                     call CocAction('doHover')
    --                 endif
    --             endfunction
    --             set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    --         ]])
    --     end,
    --     keys = {
    --         --{ "gd", "<Plug>(coc-definition)", desc = "Go to Definition" },
    --         { "gy", "<Plug>(coc-type-definition)", noremap = true, desc = "Go to Type Definition" },
    --         { "gi", "<Plug>(coc-implementation)", desc = "Go to Implementation" },
    --         { "gr", "<Plug>(coc-references)", desc = "Go to References" },
    --         { "<leader>rn", "<Plug>(coc-rename)", desc = "Rename Symbol" },
    --         { "<leader>ca", "<Plug>(coc-codeaction)", desc = "Code Action" },
    --         { "K", "<cmd>call <SID>show_documentation()<CR>", desc = "Show Documentation" },
    --         { "<leader>=", "<Plug>(coc-format-selected)", mode="x", desc = "Format Selected Code" },
    --         { "<leader>a", "<Plug>(coc-codeaction-selected)", mode="x", desc = "Code Action Selected" },
    --         { "<leader>ac", "<Plug>(coc-codeaction)", desc = "Code Action on current line" },
    --         { "<leader>qf", "<Plug>(coc-fix-current)", desc = "Fix Current Issue on current line" },
    --     },
    -- },
    {
        "neovim/nvim-lspconfig",
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "petertriho/cmp-git",
            "quangnguyen30192/cmp-nvim-ultisnips",
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lua",
            "kbwo/cmp-yank",
            "rcarriga/cmp-dap",
            {
                "zbirenbaum/copilot-cmp",
                config = function ()
                    require("copilot_cmp").setup()
                end
            },
        },

        config = function()
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
                    end,
                },
                performance = {
                    debounce = 20,
                },
                window = {
                    completion = {
                        --border = {"🭽","▔","🭾","▕","🭿","▁","🭼","▏"},
                        --border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:PmenuSel",
                        scrollbar = false,
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = {
                        --border = {"▞","▔","▚","▕","▞","▁","▚","▏"},
                        --border = {"🭽","▔","🭾","▕","🭿","▁","🭼","▏"},
                        --border = {"╱","▔","╲","▕","╱","▁","╲","▏"},
                        --border = "solid",
                        border = {" ",""," "," "," ",""," "," "},
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:PmenuSel",
                        max_width = 100,
                        max_height = 100,
                    },
                },
                preselect = cmp.PreselectMode.Item,
                completion = {
                    -- completeopt = "menu,menuone,noselect",
                },
                formatting = {
                    fields = { "icon", "abbr", "menu", "kind" },
                    format = function(entry, vim_item)
                        local lspkind = require("lspkind")
                        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" } })(entry, vim_item)
                        kind.icon = " " .. (kind.icon or "") .. "  "
                        kind.kind = "   (" .. (kind.kind or "") .. ")"

                        return kind
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    -- Navigate between completion items
                    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'insert'}),
                    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'insert'}),

                    -- `Enter` key to confirm completion
                    -- ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<C-j>'] = cmp.mapping.confirm({select = true}),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "ultisnips" },
                    { name = "path" },
                    { name = "git" },
                    { name = "yank" },
                }, {
                        { name = "buffer" },
                    }),
                sorting = defaults.sorting,
            })
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' },
                        { name = 'cmdline_history', max_item_count = 5 },
                    }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
            require("cmp").setup({
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                        or require("cmp_dap").is_dap_buffer()
                end
            })

            require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig"
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim"
        },
        opts = {
            ensure_installed = {
            }
        }
    },
    {
        'mrcjkb/rustaceanvim',
        --version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        enabled = false,
        opts = {
            hint_enable = false,
            doc_lines = 30,
            max_height = 35,
        },
    },
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" }, -- optional
        dependencies = {
            --"folke/snacks.nvim", -- optional
            --"nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua" -- optional
        },
    },
    {
        "j-hui/fidget.nvim",
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup {
                outline_window = {
                    width = 15,
                    focus_on_open = false,
                },
                guides = {
                    enabled = true,
                    markers = {
                        -- It is recommended for bottom and middle markers to use the same number
                        -- of characters to align all child nodes vertically.
                        bottom = '  └',
                        middle = '  ├',
                        vertical = '  │',
                    },
                },
                symbol_folding = {
                    -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
                    autofold_depth = false,
                    -- When to auto unfold nodes
                    auto_unfold = {
                        -- Auto unfold currently hovered symbol
                        hovered = true,
                        -- Auto fold when the root level only has this many nodes.
                        -- Set true for 1 node, false for 0.
                        only = true,
                    },
                    markers = { '', '' },
                },
                preview_window = {
                    -- Automatically open preview of code location when navigating outline window
                    auto_preview = true,
                    -- Automatically open hover_symbol when opening preview (see keymaps for
                    -- hover_symbol).
                    -- If you disable this you can still open hover_symbol using your keymap
                    -- below.
                    open_hover_on_preview = false,
                    width = 35,     -- Percentage or integer of columns
                    min_width = 35, -- Minimum number of columns
                    -- Whether width is relative to the total width of nvim.
                    -- When relative_width = true, this means take 50% of the total
                    -- screen width for preview window, ensure the result width is at least 50
                    -- characters wide.
                    relative_width = true,
                    height = 35,     -- Percentage or integer of lines
                    min_height = 10, -- Minimum number of lines
                    -- Similar to relative_width, except the height is relative to the outline
                    -- window's height.
                    relative_height = true,
                    -- Border option for floating preview window.
                    -- Options include: single/double/rounded/solid/shadow or an array of border
                    -- characters.
                    -- See :help nvim_open_win() and search for "border" option.
                    border = 'single',
                    -- winhl options for the preview window, see ':h winhl'
                    winhl = 'NormalFloat:',
                    -- Pseudo-transparency of the preview window, see ':h winblend'
                    winblend = 10,
                    -- Experimental feature that let's you edit the source content live
                    -- in the preview window. Like VS Code's "peek editor".
                    live = false
                },
                symbols = {
                    icon_source = "lspkind",
                },
            }
        end,
    },
}
