vim.o.background = "dark" -- or "light" for light mode
vim.o.termguicolors = true
vim.cmd([[
    colorscheme gruvbox
    highlight ColorColumn guibg=gray20
    highlight ColorColumn ctermbg=236
    highlight SignColumn ctermbg=none
    "highlight NormalFloat guibg=#504945
    highlight CocInlayHint guifg=grey50 guibg=#282828 cterm=italic gui=italic
    highlight CurrentWord ctermbg=238 guibg=gray23 gui=none cterm=none
    highlight CurrentWordTwins ctermbg=238 guibg=gray23 gui=none cterm=none
]])
