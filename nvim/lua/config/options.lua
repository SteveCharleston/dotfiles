local vim = vim  -- suppress undefined variable warning

vim.o.guicursor = "n-v-c-i:block"
vim.cmd("syntax on")  -- enable syntax highlighting

local options = {
    compatible = false,   -- be iMproved
    autoindent = true,    -- auto indent code
    copyindent = true,    -- use existing indentation structur when pasting
    background = "dark", -- optimize color theme for dark backgrounds
    showcmd = true,       -- Show (partial) command in status line.
    showmatch = true,     -- Show matching brackets.
    ignorecase = true,    -- Do case insensitive matching
    smartcase = true,     -- But still be intelligent about matchin But still be intelligent about matching
    mouse = "a",          -- Enable mouse usage (all modes)
    sw = 4,               -- space indentation witdh 4 (the best wide)
    hlsearch = true,      -- Highlight search items
    incsearch = true,     -- Incremental search, start searching as soon as I type
    number = true,        -- Show Line Numbers
    autochdir = false,    -- never switch to the current file directory 
    hidden = true,        -- change buffers without saving
    title = true,         -- Let vim set the xterm title
    startofline = false,  -- leave the cursor where it is
    wrap = false,         -- don't wrap long lines
    scrolloff = 3,        -- minimum lines to keep above and below cursor
    gdefault = true,      -- the /g flag on :s substitutions by default
    shiftround = true,    -- indent to multiples of shiftwidth
    colorcolumn = { 80 }, -- Higlights Characters after 80 characters
    showmode = false,    -- don't show mode since we use a statusline

    list = true,          -- show some invisible characters
    listchars = {         -- configure the invisible characters
        tab = "' ",       -- show tabs as ' followed by spaces
        trail=".",        -- show trailing spaces as .
        extends="#",      -- show when line extends beyond screen with #
        nbsp="."          -- show non breaking spaces as .
    },

    wildmenu = true,      -- command completition using <Tab>
    wildmode = {
        "list:longest",   -- first tab shows a list
        "full"            -- second tab completes fully
    },
    wildoptions = {
        "pum",
        --"fuzzy",
        "tagfile"
    },

    backspace = {         -- make backspace a more flexible
        "indent",
        "eol",
        "start"
    },

    completeopt = {       -- display the completition menu and a preview window
        "menu",
        "preview"
    },

    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,     -- convert tabs to spaces
    undofile = true,      -- Maintain undo history between sessions
    iskeyword  = { "@", "48-57", "_", "192-255" },
    timeoutlen = 1000,
    ttimeoutlen = 10,

    backup = true,
    backupdir = "/tmp/,.",
    directory = "/tmp/,.",
    keymodel = "startsel,stopsel",
    ruler = true,
    selection = "inclusive",
    updatetime = 300,
    whichwrap = "b,s,<,>,[,],h,l",
    fillchars = "vert:│,fold:-"  -- nicer buffer borders
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.diffopt:append("algorithm:histogram") -- open diffs in vertical split
