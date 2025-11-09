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
                        max_width = 0,
                        max_height = 0,
                    },
                },
                preselect = cmp.PreselectMode.Item,
                completion = {
                    -- completeopt = "menu,menuone,noselect",
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = { Copilot = "" } })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

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
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
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
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
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
    }
}
