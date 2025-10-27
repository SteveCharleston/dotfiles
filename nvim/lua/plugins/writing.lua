return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.tex_flavor = "latex"
        end,
    },
    "rhysd/vim-grammarous",
    {
        "dpelle/vim-LanguageTool",
        init = function()
            vim.g.languagetool_jar = "/home/steven/bin/languagetool/languagetool-commandline.jar"
            vim.g.languagetool_lang = "de-DE"
            vim.g.languagetool_disable_rules = "LEERZEICHEN_HINTER_DOPPELPUNKT,GERMAN_SPELLER_RULE"
        end,
    },
    "dbmrq/vim-ditto",
    {
        "ron89/thesaurus_query.vim",
        init = function()
            vim.g.tq_map_keys = 0
            vim.g.tq_language='de'
        end,
    },
    {
        "obsidian-nvim/obsidian.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
        opts = {
            workspaces = {
                { name = "personal", path = "~/notes/" },
            },
            legacy_commands = false,
            daily_notes = {
                folder = "daily",
                date_format = "%Y-%m-%d.%a",
            },
            templates = {
                folder = "tmpl",
                date_format = "%Y-%m-%d.%a",
            },
            attachments = {
                img_folder = "tmpl",
            },
            ui = {
                enable = true,
                bullets = { char = "", hl_group = "ObsidianBullet" },
                max_file_length = 100000,
            },
            checkbox = {
                order = { " ", "x" },
            },
            picker = {
                name = "fzf-lua",
                note_mappings = {
                    new = "<C-x>",
                    insert_link = "<C-l>",
                },
                tag_mappings = {
                    tag_note = "<C-x>",
                    insert_tag = "<C-l>",
                }
            },
            wiki_link_func = "use_alias_only", -- Create as [[link]]
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
                -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                    suffix = tostring(os.time()) .. "-" .. suffix
                end
                return suffix
            end,

        },
        init = function()
            vim.cmd([[
                augroup markdown_conceal
                autocmd!
                " Setup formatexpr specified filetype(s).
                autocmd FileType markdown setlocal conceallevel=1 concealcursor=n
                augroup end
            ]])
        end,
        keys = {
            { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
            { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian Yesterday" },
            { "<leader>om", "<cmd>Obsidian tomorrow<cr>", desc = "Obsidian Tomorrow" },
            { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian New Note" },
            { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Obsidian Search" },
            { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
            { "<leader>oa", "<cmd>Obsidian tags<cr>", desc = "Obsidian Tags" },
            { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Obsidian Dailies" },
        },
    }
}
