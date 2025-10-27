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
map("n", "<M-h>", "<cmd>wincmd h<CR>", { silent = true, desc = "Move to left window" })
map("n", "<M-j>", "<cmd>wincmd j<CR>", { silent = true, desc = "Move to lower window" })
map("n", "<M-k>", "<cmd>wincmd k<CR>", { silent = true, desc = "Move to upper window" })
map("n", "<M-l>", "<cmd>wincmd l<CR>", { silent = true, desc = "Move to right window" })
map("n", "-",     "<cmd>wincmd -<CR>", { silent = true, desc = "Decrease window height" })
map("n", "+",     "<cmd>wincmd +<CR>", { silent = true, desc = "Increase window height" })
map("n", "<M-<>", "<cmd>wincmd <<CR>", { silent = true, desc = "Decrease window width" })
map("n", "<M->>", "<cmd>wincmd ><CR>", { silent = true, desc = "Increase window width" })

-- " Additional helper mappings
map("n", "<leader>jf", "<cmd>NERDTreeFind<cr>", { desc = "Find current file in NERDTree" })
map("n", "<leader>js", "<cmd>Git<cr>",           { desc = "Open Git interface" })
map("n", "<leader>jgp", "<cmd>Git push<cr>",     { desc = "Git push" })
map("n", "<leader>jgc", "<cmd>Git commit -avs<cr>", { desc = "Git commit with all changes and verbose" })
map("n", "<leader>jgr", "<cmd>Git pull --rebase<cr>", { desc = "Git pull with rebase" })
map("n", "<leader>jt", "<cmd>Twiggy<cr>",        { desc = "Open Twiggy for Git history" })
map("n", "<leader>jl", "<cmd>GV<cr>",           { desc = "Open Git commit graph" })
