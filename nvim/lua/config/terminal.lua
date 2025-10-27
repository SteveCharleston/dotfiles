-- Some settings for terminal mode
vim.api.nvim_set_hl(0, "Terminal", { bg = "black", fg = "lightgray" })
vim.keymap.set("t", "jk", [[<C-\><C-n>]],         { noremap = true, desc = "Exit terminal mode" })
