local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

map("i", "ubpy", "#!/usr/bin/python",  { desc = "Insert Python shebang" })

map("i", "syso", "System.out.println();<LEFT><LEFT>",
                                       { desc = "Insert Java System.out.println" })

map("i", ";<cr>", "<C-o>A;<C-o>A<cr>", { noremap = true, desc = "Insert semicolon at end of line and go to new line" })
map("i", ";;",    "<C-o>A;",           { noremap = true, desc = "Insert semicolon at end of line" })
map("i", "<C-l>", "<C-k>",             { noremap = true, desc = "Insert Digraphs with C-l" })
map("n", "<F9>",  ":make<cr>",         { noremap = true, desc = "Run make command" })

-- Faster Scrolling
map("n", "<C-e>", "3<C-e>",            { noremap = true, desc = "Scroll down 3 lines" })
map("n", "<C-y>", "3<C-y>",            { noremap = true, desc = "Scroll up 3 lines" })

-- Easy Window Handling
map("n", "<M-h>", function() vim.cmd(vim.v.count1 .. "wincmd h") end, { silent = true, desc = "Move to left window" })
map("n", "<M-j>", function() vim.cmd(vim.v.count1 .. "wincmd j") end, { silent = true, desc = "Move to lower window" })
map("n", "<M-k>", function() vim.cmd(vim.v.count1 .. "wincmd k") end, { silent = true, desc = "Move to upper window" })
map("n", "<M-l>", function() vim.cmd(vim.v.count1 .. "wincmd l") end, { silent = true, desc = "Move to right window" })
map("n", "-",     function() vim.cmd(vim.v.count1 .. "wincmd -") end, { silent = true, desc = "Decrease window height" })
map("n", "+",     function() vim.cmd(vim.v.count1 .. "wincmd +") end, { silent = true, desc = "Increase window height" })
map("n", "<M-<>", function() vim.cmd(vim.v.count1 .. "wincmd <") end, { silent = true, desc = "Decrease window width" })
map("n", "<M->>", function() vim.cmd(vim.v.count1 .. "wincmd >") end, { silent = true, desc = "Increase window width" })

-- " Additional helper mappings
map("n", "<leader>jf", "<cmd>NERDTreeFind<cr>", { desc = "Find current file in NERDTree" })
map("n", "<leader>js", "<cmd>Git<cr>",           { desc = "Open Git interface" })
map("n", "<leader>jgp", "<cmd>Git push<cr>",     { desc = "Git push" })
map("n", "<leader>jgc", "<cmd>Git commit -avs<cr>", { desc = "Git commit with all changes and verbose" })
map("n", "<leader>jgr", "<cmd>Git pull --rebase<cr>", { desc = "Git pull with rebase" })
map("n", "<leader>jt", "<cmd>Twiggy<cr>",        { desc = "Open Twiggy for Git history" })
map("n", "<leader>jl", "<cmd>GV<cr>",           { desc = "Open Git commit graph" })
map("n", "<space>d", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
