augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" neovim stuff
set termguicolors
if has('nvim')
    let g:python2_host_prog = '/usr/bin/python'
    set guicursor=
    autocmd OptionSet guicursor noautocmd set guicursor=
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
endif

call plug#begin('~/.vim/bundle')

"Plug 'vim-scripts/ref.vim'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
"Plug 'Finder-for-vim'
"Plug 'vim-scripts/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
"Plug 'visual-increment'
"Plug 'vim-scripts/Python-2.x-Standard-Library-Reference'
"Plug 'vim-scripts/htmlspecialchars'
"Plug 'Shougo/vimproc', { 'do': 'make' }
Plug 'artur-shaik/vim-javacomplete2'
Plug 'vim-scripts/surround.vim'
Plug 'wellle/targets.vim'
Plug 'vim-scripts/repeat.vim'
"Plug 'vim-scripts/vcscommand.vim'
Plug 'inkarkat/vcscommand.vim'
Plug 'paranoida/vim-airlineish'
Plug 'hsanson/vim-android'
Plug 'tmatilai/vim-monit'
Plug 'tpope/vim-dispatch'
Plug 'justinmk/vim-gtfo'
"Plug 'godlygeek/csapprox'
"Plug 'KevinGoodsell/vim-csexact'
"Plug 'xieyu/pyclewn'
Plug 'justinmk/vim-syntax-extra'
"Plug 'Rip-Rip/clang_complete'
Plug '4Evergreen4/vim-hardy'
"Plug 'stevearc/vim-arduino'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-speeddating'
Plug 'cosminadrianpopescu/filesync'
"Plug 'johngrib/vim-game-code-break'
Plug 'vim-scripts/tcd.vim'
"Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'
Plug 'thinca/vim-visualstar'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'junegunn/vim-journal'
Plug 'cespare/vim-toml'
"Plug 'kyazdani42/nvim-tree.lua'

if has('nvim')
"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sontungexpt/url-open', { 'branch': 'main' }
endif

"Plug 'vim-vdebug/vdebug'
"Plug 'editorconfig/editorconfig-vim'

" Color Schemes
if has('nvim')
Plug 'ellisonleao/gruvbox.nvim', { 'branch': 'main' }
else
Plug 'gruvbox-community/gruvbox'
endif
Plug 'sainnhe/everforest'
Plug 'loctvl842/monokai-pro.nvim'

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Basic vim Options 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " be iMproved
filetype off            " required!
filetype plugin on      " load plugins instead
syntax on               " syntax highlighting
set autoindent          " auto indent code
set copyindent          " use existing indentation structur when pasting
set background=light    " optimize color theme for light backgrounds

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase           " But still be intelligent about matchin But still be intelligent about matching
set mouse=a		" Enable mouse usage (all modes)
set sw=4		" space indentation wide 4
set hlsearch		" Highlight search items
set incsearch		" Incremental search, start searching as soon as I type
set number		" Show Line Numbers
set noautochdir         " never switch to the current file directory 
set hidden              " change buffers without saving
set title               " Let vim set the xterm title
set nostartofline       " leave the cursor where it is
set expandtab           " no real tabs
set nowrap              " don't wrap long lines
set showmatch           " on bracket insert jump to matching one for short time
set scrolloff=3         " minimum lines to keep above and below cursor
set gdefault            " the /g flag on :s substitutions by default
set shiftround          " indent to multiples of shiftwidth
set wildmenu            " command completition using <Tab>
set colorcolumn=80      "Higlights Characters after 80 characters
set list
set listchars=tab:'\ ,trail:.,extends:#,nbsp:. " make special chars visible
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set backspace=indent,eol,start " make backspace a more flexible
set completeopt=menu,preview " display the completition menu and a preview window
set softtabstop=4 shiftwidth=4 expandtab 
set omnifunc=syntaxcomplete#Complete
set guioptions=ci
set tags=./tags;
set undofile            " Maintain  history between sessions
set iskeyword=@,48-57,_,192-255
set timeoutlen=1000 ttimeoutlen=10

if !has('nvim')
    set ttymouse=sgr        " Resize splits inside tmux
endif


" Arbeit

set backup
set backupdir=/tmp,.
set directory=/tmp,.
"set diffexpr=
set diffopt+=algorithm:patience
""set guifont=Courier_New:h10:cANSI
set guifont=Liberation\ Mono\ 10
set helplang=de
set history=1000
set keymodel=startsel,stopsel
set ruler
set selection=inclusive
set updatetime=300
set whichwrap=b,s,<,>,[,]

"let mapleader = "\<tab>"
let mapleader = " "
let maplocalleader="\<space>"

" load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" Enable extendet % matching
runtime macros/matchit.vim
" Read man pages with vim
runtime! ftplugin/man.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Styling
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" File reading
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows to read PDF files with VIM by piping them through pdftotext
autocmd BufReadPre *.pdf set ro
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78

" Same for word files with antiword
autocmd BufReadPre *.doc set ro
autocmd BufReadPost *.doc %!antiword "%"


"""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Key Remappings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
    set pastetoggle=<F10>
endif
imap jj <Esc>
imap jk <Esc>
imap ubpy #!/usr/bin/python
imap syso System.out.println();<LEFT><LEFT>
"inoremap ;<cr> <end>;<cr>
"inoremap ;; <end>;
inoremap ;<cr> <C-o>A;<C-o>A<cr>
inoremap ;; <C-o>A;
inoremap <C-l> <C-k>
nnoremap <F9> :make<cr>

" Faster Scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" visual shifting (does not exit Visual mode)
"vnoremap < <gv
"vnoremap > >gv 

" Easy Window Handling
nmap <silent> <M-h> :wincmd h<CR>
nmap <silent> <M-j> :wincmd j<CR>
nmap <silent> <M-k> :wincmd k<CR>
nmap <silent> <M-l> :wincmd l<CR>
nmap - <C-W>-
nmap + <C-W>+
nmap <silent> <M-<> :wincmd <<CR>
nmap <silent> <M->> :wincmd ><CR>

nmap <silent> h :wincmd h<CR>
nmap <silent> j :wincmd j<CR>
nmap <silent> k :wincmd k<CR>
nmap <silent> l :wincmd l<CR>
nmap <silent> < :wincmd <<CR>
nmap <silent> > :wincmd ><CR>

" terminal mappings
hi Terminal ctermbg=black ctermfg=lightgray guibg=black guifg=lightgrey
tnoremap jk <C-\><C-n>
if !has('nvim')
    set termwinkey=<C-j>
else
    nmap gx <esc>:URLOpenUnderCursor<CR>
endif

" Commands
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" Show the current colorscheme highlight group
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-Menu
Plug 'skywind3000/vim-quickui'


" NERDtree
"Plug 'vim-scripts/The-NERD-tree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=2
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=0
let g:NERDTreeDirArrows = 0
let NERDTreeCascadeSingleChildDir=0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeNodeDelimiter = "\u00a0" " to avoid ^G in some displays
"let g:NERDTreeDirArrowExpandable = '▷'
"let g:NERDTreeDirArrowCollapsible = '▽'
"let g:NERDTreeDirArrowExpandable = '⟩'
"let g:NERDTreeDirArrowCollapsible = '∨'
"
" NERDTree Colors
function! NThl(mtch, cs)
  exec "autocmd filetype nerdtree syn match " . a:mtch . " #^\\s\\+.*" . a:mtch . "\\*\\?$#"
  exec "autocmd filetype nerdtree highlight " . a:mtch . " " . a:cs
endfunction
augroup MyNerdTree
  autocmd!
  call NThl('php', 'ctermfg=077 guifg=#5FD75F gui=BOLD cterm=BOLD')
  call NThl('css', 'ctermfg=57 guifg=#5F00FF gui=BOLD cterm=BOLD')
  autocmd filetype nerdtree highlight Directory ctermfg=166 guifg=#D75F00 gui=BOLD cterm=BOLD
augroup END " MyNerdTree
highlight NERDTreeDirSlash guifg=#005F87 ctermfg=24 gui=BOLD cterm=BOLD
highlight NERDTreeCWD guifg=#444444 ctermfg=238 gui=BOLD cterm=BOLD
highlight NERDTreeOpenable guifg=#005F87 ctermfg=24 gui=BOLD cterm=BOLD
highlight NERDTreeClosable guifg=#00AFFF ctermfg=39 gui=BOLD cterm=BOLD

" Tag list """"""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/taglist.vim', { 'on': 'TlistToggle' }
let Tlist_Auto_Open=0	" Automatically Open the Tag List
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself 
let Tlist_Use_Right_Window = 1


" Tagbar     """"""""""""""""""""""""""""""""""""""
"Plug 'vim-scripts/Tagbar'
Plug 'majutsushi/tagbar'
let g:tagbar_left=0
let g:tagbar_singleclick=1
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : 'ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" vista """""""""""""""""""""""""""""""""""
Plug 'liuchengxu/vista.vim'

" fswitch  """""""""""""""""""""""""""""""""""
Plug 'derekwyatt/vim-fswitch'
nnoremap <C-7> :FSHere<cr>
nnoremap  :FSHere<cr>

" PlantUML """""""""""""""""""""""""""""""""""""
Plug 'aklt/plantuml-syntax'

" Denite  """""""""""""""""""""""""""""""""""
"Plug 'Shougo/denite.nvim'
"map <C-p> :Denite file/rec<cr>
"nnoremap <Leader>b :Denite buffer<cr>
"nnoremap <Leader>g :Denite buffer<cr>

" svn  """""""""""""""""""""""""""""""""""
Plug 'juneedahamed/vc.vim'
let g:no_vc_maps = 1

" Git  """""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'idanarye/vim-merginal'
Plug 'sodapopcan/vim-twiggy'
Plug 'rhysd/git-messenger.vim'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'sindrets/diffview.nvim', {'branch': 'main'}

Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
if filereadable(expand("~/.gitlab_credentials"))
    source ~/.gitlab_credentials
endif

autocmd FileType git set foldmethod=syntax
autocmd FileType fugitive nnoremap <buffer> q :<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>

let g:git_messenger_no_default_mappings = v:true
nmap <C-w>m <Plug>(git-messenger)

" Unite  """""""""""""""""""""""""""""""""""
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'liquidz/ctrlp-gonosen.vim'
Plug 'sgur/ctrlp-extensions.vim'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_open_multiple_files = '2i'
let g:ctrlp_custom_ignore = '\v.+\.(aux|fls|fdb_latexmk|gls|glo|glg|out|log|ind|gz|toc|pdf|ilg|idx|dvi|xdy|ist|alg|acr|acn)'
let g:Lf_SpinSymbols = ['🌘', '🌗', '🌖', '🌕', '🌔', '🌓', '🌒', '🌑']
"nnoremap <Leader>b :CtrlPBuffer<cr>
"nnoremap <Leader>g :CtrlPBuffer<cr>
"nnoremap <Leader>m :CtrlPMRUFiles<cr>
"nnoremap <Leader>t :CtrlPTag<cr>
"nnoremap <Leader>f :CtrlPFunky<cr>
"nnoremap <Leader>l :CtrlPLine<cr>

" LeaderF  """""""""""""""""""""""""""""""""""
Plug 'Yggdroot/LeaderF'
"nnoremap <c-p> :LeaderfFile<cr>
let g:Lf_ShortcutF = '<C-P>'
"let g:Lf_ShortcutB = '<leader>g'
nnoremap <Leader>f :LeaderfBufTag<cr>
nnoremap <Leader>l :LeaderfLine<cr>
nnoremap <Leader>t :LeaderfTag<cr>
nnoremap <Leader>m :LeaderfMru<cr>
let g:ctrlp_map = ''
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlColorscheme = 'gruvbox_material'

let g:Lf_PopupPreviewPosition="right"
let g:Lf_PopupBorders = ["─","│","─","│","╭","╮","╯","╰"]

let g:Lf_PreviewResult = {
        \ 'File': 1,
        \ 'Buffer': 1,
        \ 'Mru': 1,
        \ 'Tag': 0,
        \ 'BufTag': 1,
        \ 'Function': 1,
        \ 'Line': 0,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0
        \}

"let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }

" Fzf  """""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nnoremap <Leader>g :Buffers<cr>

" Ale """""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed = 'always'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_set_balloons = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
"let g:ale_java_javac_classpath = '/home/steven/bin/android/sdk/platforms/android-28/android.jar'
let b:ale_fixers = ['autopep8', 'yapf']
let g:ale_virtualtext_cursor = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'

if has('nvim')
Plug 'luozhiya/lsp-virtual-improved.nvim'

let g:ale_use_neovim_diagnostics_api = 1
let g:ale_virtualtext_cursor = 0
sign define DiagnosticSignError text= texthl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint

lua <<EOF
vim.diagnostic.config {
    underline = true,
    --virtual_text = {
    --        --prefix = "",
    --        severity = nil,
    --        source = "if_many",
    --        --spacing = 1,
    --        format = nil,
    --},
    virtual_text = false,
    virtual_improved = {
        current_line = 'only',
        spacing = 1,
      prefix = '■', -- Same usage as virtual_text.prefix
        },
        float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    signs = true,
    severity_sort = true,
    update_in_insert = true,

}
--vim.api.nvim_create_autocmd({ "CursorHold" }, {
--	callback = function()
--            vim.diagnostic.open_float({scope="cursor"})
--	end,
--})

EOF

nnoremap <silent> <leader>e  :<C-u>lua vim.diagnostic.open_float({scope="line"})<cr>
endif

nmap <silent> <Leader>[ :ALEPrevious<cr>
nmap <silent> <Leader>] :ALENext<cr>
autocmd FileType python nnoremap <leader>= :ALEFix black isort<cr>
autocmd FileType rust nnoremap <leader>= :ALEFix rustfmt<cr>

let g:ale_linter_aliases = {
      \ 'sls': 'salt'
      \}

let g:ale_linters = {
        \ 'python': [
            \ 'mypy',
            \ 'pylint',
            \ 'flake8',
            \ 'pydocstyle',
            \ 'bandit',
        \ ] }

let g:ale_python_bandit_options = "--skip B101"
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

" neomake """""""""""""""""""""""""""""""""""""
"Plug 'neomake/neomake'

" Syntastic """""""""""""""""""""""""""""""
"Plug 'vim-scripts/Syntastic'
"Plug 'vim-syntastic/syntastic'
let g:syntastic_quiet_messages = { "regex": [
        \ '\mpossible unwanted space at "{"',
        \ 'SOME OTHER SYNTASTIC MESSAGE',
        \ ] }

" Youcompleteme """""""""""""""""""""""""""
"Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Echodoc """""""""""""""""""
Plug 'Shougo/echodoc.vim'
set noshowmode
let g:echodoc_enable_at_startup = 1

" NCM2 """""""""""""""""""
"Plug 'ncm2/ncm2'
"" ncm2 requires nvim-yarp
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-pyclang'
"let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
"
"" enable ncm2 for all buffer
"autocmd BufEnter * call ncm2#enable_for_buffer()
"
"" note that must keep noinsert in completeopt, the others is optional
"set completeopt=noinsert,menuone,noselect
"
"" supress the annoying 'match x of y', 'The only match' and 'Pattern not
"" found' messages
"set shortmess+=c
"
"" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
"inoremap <c-c> <ESC>
"
"" When the <Enter> key is pressed while the popup menu is visible, it only
"" hides the menu. Use this mapping to close the menu and also start a new
"" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"
"" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"" some completion sources
"Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-ultisnips'
"
"Plug 'ncm2/ncm2-abbrfuzzy'
"
"let g:ncm2#matcher = 'abbrfuzzy'
"" use a sorter that's more friendly for fuzzy match
"let g:ncm2#sorter = 'abbrfuzzy'
"
"let g:ncm2#complete_length = [[1,2],[7,2]]

" Termdebug """""""""""""""""""
packadd termdebug
let g:termdebug_wide = 25
let termdebugger="rust-gdb"

Plug 'nvim-neotest/nvim-nio'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" CoC """""""""""""""""""
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
            \'coc-css',
            \'coc-diagnostic',
            \'coc-emmet',
            \'coc-git',
            \'coc-html',
            \'coc-java',
            \'coc-json',
            \'coc-lists',
            \'coc-omni',
            \'coc-jedi',
            \'coc-sh',
            \'coc-snippets',
            \'coc-ultisnips',
            \'coc-vimtex',
            \'coc-yaml',
            \'coc-yank',
            \]
            "\'coc-highlight',
            "\'coc-pyright',
            "\'coc-python',



nmap <leader>d <Plug>(coc-definition)
"nmap <leader>a <Plug>(coc-codeaction)
"nmap <leader>e <Plug>(coc-codelens-action)
"nmap <leader>r <Plug>(coc-refactor)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
"				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>=  <Plug>(coc-format-selected)
"nmap <leader>=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)


" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"nmap <silent> <Leader>[ <Plug>(coc-diagnostic-prev)
"nmap <silent> <Leader>] <Plug>(coc-diagnostic-next)


"" Use <C-l> for trigger snippet expand.
"imap <C-k> <Plug>(coc-snippets-expand)
"
"" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-k> <Plug>(coc-snippets-select)
"
"" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-k>'
"
"" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-k> <Plug>(coc-snippets-expand-jump)

" Copilot """""""""""""""""""
Plug 'github/copilot.vim', { 'branch': 'release' }
"Plug 'gptlang/CopilotChat.nvim', { 'branch': 'main' }
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }
imap <M-C-N> <Plug>(copilot-accept-word)
let g:copilot_chat_disable_separators = 0

" Testing """""""""""""""""""
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest'
let g:ultest_deprecation_notice = 0
let g:ultest_running_sign = ""


" completor """""""""""""""""""
"Plug 'maralla/completor.vim'
"let g:completor_complete_options = 'menuone,noselect'

" Deoplete """""""""""""""""""
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  Plug 'ncm2/float-preview.nvim'
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"Plug 'deoplete-plugins/deoplete-jedi'
"
"Plug 'Shougo/deoplete-clangx'
"Plug 'Shougo/neco-syntax'
"Plug 'wellle/tmux-complete.vim'
""Plug 'ujihisa/neco-look'
"let g:deoplete#enable_at_startup = 1
""
"" floating window
"let g:float_preview#docked = 0
"let g:float_preview#max_width = 100
"let g:deoplete#sources#jedi#show_docstring = 1
"
"" Use smartcase.
""call deoplete#custom#option('smart_case', v:true)
"set completeopt-=preview
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
"
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
"    return deoplete#close_popup() . "\<CR>"
"endfunction

" nvim-completition-manager """""""""""""""
"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/vim-hug-neovim-rpc'
"
"let g:cm_matcher = get(g:,'cm_matcher',{'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'})
"let g:cm_refresh_default_min_word_len=2 " Trigger the popup after typing 2 characters
"
"augroup my_cm_setup
"    autocmd!
"    autocmd User CmSetup call cm#register_source({
"                \ 'name' : 'vimtex',
"                \ 'priority': 8,
"                \ 'scoping': 1,
"                \ 'scopes': ['tex'],
"                \ 'abbreviation': 'tex',
"                \ 'cm_refresh_patterns': g:vimtex#re#ncm,
"                \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
"                \ })
"augroup END
"
"au User CmSetup call cm#register_source({'name' : 'cm-java',
"		\ 'priority': 9, 
"		\ 'scoping': 0,
"		\ 'scopes': ['java'],
"		\ 'abbreviation': 'java',
"		\ 'cm_refresh_patterns': ['\w\+\.'],
"		\ 'cm_refresh': {'omnifunc': 'javacomplete#Complete'},
"		\ })

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Ultisnips """""""""""""""""""""""""""""""
Plug 'SirVer/ultisnips'
Plug 'SteveCharleston/vim-snippets'
"inoremap <silent> <buffer> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
"let g:UltiSnipsRemoveSelectModeMappings = 0
"let g:UltiSnipsExpandTrigger="<c-k>"
"let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsExpandOrJumpTrigger = "<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
""let g:UltiSnipsJumpBackwardTrigger="<c-K>"
let g:ultisnips_python_style = 'sphinx'
let g:EclimCompletionMethod = 'omnifunc'


"function! g:UltiSnips_Complete()
"    call UltiSnips#ExpandSnippet()
"    if g:ulti_expand_res == 0
"        if pumvisible()
"            return "\<C-n>"
"        else
"            call UltiSnips#JumpForwards()
"            if g:ulti_jump_forwards_res == 0
"               return "\<TAB>"
"            endif
"        endif
"    endif
"    return ""
"endfunction
"
"au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-e>"
"" this mapping Enter key to <C-y> to chose the current highlight item 
"" and close the selection list, same as other IDEs.
"" CONFLICT with some plugins like tpope/Endwise
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" For snippet_complete marker.
if has('conceal')
  set conceallevel=0 concealcursor=i
endif


" vimtex """""""""""""""""""""""""""""""""""
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
  if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_semantic_triggers.tex = [
        \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
        \ 're!\\hyperref\[[^]]*',
        \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(include(only)?|input){[^}]*',
        \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
        \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\[A-Za-z]*',
        \ ]

" Languagetool  """""""""""""""""""""""""""""""""""
Plug 'rhysd/vim-grammarous'
Plug 'dpelle/vim-LanguageTool'
let g:languagetool_jar = '/home/steven/bin/languagetool/languagetool-commandline.jar'
let g:languagetool_lang = 'de-DE'
let g:languagetool_disable_rules = 'LEERZEICHEN_HINTER_DOPPELPUNKT,GERMAN_SPELLER_RULE'

Plug 'dbmrq/vim-ditto'

" Thesaurus  """""""""""""""""""""""""""""""""""
Plug 'ron89/thesaurus_query.vim'
let g:tq_map_keys = 0
let g:tq_language='de'
" this plugin can also be invoked with ctrl-x ctrl-u in insert mode
vnoremap <Leader>ts y:ThesaurusQueryReplace <C-r>"<CR>
nnoremap <Leader>ts :ThesaurusQueryReplaceCurrentWord<CR>

" Clang """""""""""""""""""""""""""""""""""
"Plug 'justmao945/vim-clang'
"Plug 'roxma/clang_complete'
let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'


" EasyMotion """"""""""""""""""""""""""""""""""
"Plugin 'EasyMotion'
"nnoremap <Space> H:call EasyMotion#F(0, 0)<CR>
Plug 'Lokaltog/vim-easymotion'
"nmap <Space> <Plug>(easymotion-bd-f)
"nmap <Space><Space> <Plug>(easymotion-jumptoanywhere)
"nmap <Leader>w <Plug>(easymotion-jumptoanywhere)
nmap <Leader>w <Plug>(easymotion-bd-f)
nmap <C-j> <Plug>(easymotion-sn)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_add_search_history = 0

" aerojump """"""""""""""""""""""""""""""""""
Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
"nmap <Leader>a <Plug>(AerojumpDefault)

" wilder """"""""""""""""""""""""""""""""""
"Plug 'gelguy/wilder.nvim'

" easyalign """"""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Highlight """"""""""""""""""""""""""""""""""
Plug 'dominikduda/vim_current_word'
" Twins of word under cursor:
let g:vim_current_word#highlight_twins = 1
" The word under cursor:
let g:vim_current_word#highlight_current_word = 1

" Orgmode """"""""""""""""""""""""""""""""""
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-repeat'
Plug 'mattn/calendar-vim'
Plug 'inkarkat/vim-SyntaxRange'
let g:calendar_weeknm = 4


" Slimux """""""""""""""""""""""""""""""""""""
Plug 'epeli/slimux', { 'on': [ 'SlimuxREPLSendLine', 'SlimuxREPLSendSelection' ]}
map <C-c><C-c> :SlimuxREPLSendLine<CR>
vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>

" jedi-vim """""""""""""""""""""""""""""""""""""
"Plug 'davidhalter/jedi-vim' " aus wenn coc
"Plug 'ncm2/ncm2-jedi'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
"let g:jedi#show_call_signatures = "0"
"let g:jedi#show_call_signatures = 2
let g:jedi#goto_assignments_command = "<leader>a"

" perl.vim """""""""""""""""""""""""""""""""""""
"Plug 'vim-scripts/perl.vim'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
let perl_include_pod = 1
let perl_extended_vars = 1
"Plugin 'perl-support.vim'
"Plugin 'vim-perl'

" TypeScript """""""""""""""""""""""""""""""
Plug 'HerringtonDarkholme/yats.vim'

if has('nvim')
    "Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
    Plug 'runoshun/tscompletejob'
else
    Plug 'Quramy/tsuquyomi'
    let g:tsuquyomi_disable_default_mappings = 1
endif

" Salt """""""""""""""""""""""""""""""
Plug 'saltstack/salt-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
let g:sls_use_jinja_syntax = 1

" Word highlight """""""""""""""""""""""""""""""
Plug 't9md/vim-quickhl'
nmap <leader>v <Plug>(quickhl-manual-this)
xmap <leader>v <Plug>(quickhl-manual-this)
nmap <leader>V <Plug>(quickhl-manual-reset)
xmap <leader>V <Plug>(quickhl-manual-reset)

" Emmet """""""""""""""""""""""""""""""
"Plug 'mattn/emmet-vim'
"let g:user_emmet_leader_key='<C-m>'

" Quickfixsigns """""""""""""""""""""""""""""""""""""
Plug 'tomtom/quickfixsigns_vim'
"let g:quickfixsigns_classes = ['loc', 'qfl', 'marks', 'breakpoints']
let g:quickfixsigns_classes = ['qfl', 'marks', 'breakpoints']

" Ack  """""""""""""""""""""""""""""""""""""
Plug 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif
let g:ack_use_dispatch = 1

" CtrlSF  """""""""""""""""""""""""""""""""""""
Plug 'dyng/ctrlsf.vim'
cnoreabbrev S CtrlSF

" Auto Parens """""""""""""""""""""""""""""""""""""
"Plug 'Raimondi/delimitMate'
"let delimitMate_expand_cr = 1
Plug 'cohama/lexima.vim'

" CompleteParameter """""""""""""""""""""""""""""""""""""
" clashes with lexima
"Plug 'tenfyzhong/CompleteParameter.vim'
"inoremap <silent><expr> ( complete_parameter#pre_complete("()")
"smap <c-i> <Plug>(complete_parameter#goto_next_parameter)
"imap <c-i> <Plug>(complete_parameter#goto_next_parameter)

" Airline + Tabline """""""""""""""""""""""""""""
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"let g:airline#extensions#tabline#enabled = 1
"Plug 'mkitt/tabline.vim'
"Plug 'bling/vim-bufferline'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_theme = 'airlineish'
let g:airline_theme = 'dark'

" unicode symbols
"let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
"let g:airline#extensions#tabline#left_sep = '▶'
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = ''
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'

" unicode symbols
let g:airline_powerline_fonts = 1
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '#'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty=' '
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#coc#enabled = 1

let g:airline_section_z  = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%1l%#__restore__#%#__accent_bold#/%L%#__restore__#:%2v'

" always have a statusline
if has('nvim')
set laststatus=3
else
set laststatus=2
endif
"
" make everything smaller
" Disable error and warning line numbers
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#show_line_numbers = 0
" ale error_symbol >
let airline#extensions#ale#error_symbol = 'E'
" ale warning >
let airline#extensions#ale#warning_symbol = 'W'
let g:airline#extensions#whitespace#enabled = 0

" don't display fileformat if it is an unix file
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#excludes = []
"let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
"let g:airline#extensions#tabline#buffer_nr_show = 1
"
"let g:airline#extensions#syntastic#enabled = 1
"let g:airline#extensions#tagbar#enabled = 1

"Plug 'ajmwagar/vim-emoticons'

call plug#end()

"set t_Co=256
let g:gruvbox_legacy_language_groups = 1
set background=dark

if has('nvim')
lua <<EOF
require("gruvbox").setup({
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
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
      overrides = {
          DiffAdd = { bg = "#3a431a", fg = "#ebdbb2" },
    }
})
EOF
endif

color gruvbox
"hi link ALEErrorSign    Error
"hi link ALEWarningSign  Keyword
"highlight ALEError ctermbg=none cterm=underline gui=underline guifg=red
"highlight ALEWarning ctermbg=none cterm=underline gui=underline guifg=red
highlight ColorColumn guibg=gray20
highlight ColorColumn ctermbg=236
"hi VertSplit ctermbg=bg cterm=none
hi SignColumn ctermbg=none
set fillchars=vert:\│,fold:-
"hi CocFloating guibg=#504945
hi NormalFloat guibg=#504945
"hi CocInlayHint guifg=grey50 guibg=234 cterm=italic gui=italic
hi CocInlayHint guifg=grey50 guibg=#282828 cterm=italic gui=italic

" highlight current word
hi CurrentWord ctermbg=238 guibg=gray23 gui=none cterm=none
hi CurrentWordTwins ctermbg=238 guibg=gray23 gui=none cterm=none

" wilder optins
"call wilder#enable_cmdline_enter()
"set wildcharm=<Tab>
"cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
"cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
"
"" only / and ? are enabled by default
"call wilder#set_option('modes', ['/', '?', ':'])
"call wilder#set_option('renderer', wilder#wildmenu_renderer(
"      \ wilder#wildmenu_airline_theme({
"      \   'highlights': {},
"      \   'highlighter': wilder#basic_highlighter(),
"      \   'separator': '  ',
"      \   'use_powerline_symbols': 1,
"      \   'powerline_symbols': ['', ''],
"      \ })))
"
"if has('nvim')
"    call wilder#set_option('pipeline', [
"        \   wilder#branch(
"        \     wilder#substitute_pipeline(),
"        \     wilder#cmdline_pipeline({
"        \       'language': 'python',
"        \       'fuzzy': 1,
"        \     }),
"        \     wilder#search_pipeline(),
"        \     wilder#python_search_pipeline({
"        \       'pattern': wilder#python_fuzzy_pattern(),
"        \       'sorter': wilder#python_difflib_sorter(),
"        \       'engine': 're',
"        \     }),
"        \   ),
"        \ ])
"endif

" completition extra options """"
"au User Ncm2Plugin call ncm2#register_source({
"            \ 'name' : 'vimtex',
"            \ 'priority': 9, 
"            \ 'subscope_enable': 1,
"            \ 'complete_length': 1,
"            \ 'scope': ['tex'],
"            \ 'mark': 'tex',
"            \ 'word_pattern': '\w+',
"            \ 'complete_pattern': g:vimtex#re#ncm,
"            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"            \ })

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
"call neomake#configure#automake('nrwi', 500)

" denite extra options
"call denite#custom#option('default', 'prompt', '> ')
"call denite#custom#option('default', 'empty', 0)
"call denite#custom#option('default', 'auto_resize', 1)
"call denite#custom#option('default', 'auto_resume', 1)
"
"" Change file_rec matcher
"call denite#custom#source('line', 'matchers', ['matcher_regexp'])
"call denite#custom#source('file_rec, redis_mru', 'sorters', ['sorter/sublime'])
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-a>',
"      \ '<denite:move_caret_to_head>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-j>',
"      \ '<denite:move_to_next_line>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-k>',
"      \ '<denite:move_to_previous_line>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-s>',
"      \ '<denite:do_action:vsplit>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-t>',
"      \ '<denite:do_action:tabopen>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-d>',
"      \ '<denite:do_action:delete>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-b>',
"      \ '<denite:scroll_page_backwards>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-f>',
"      \ '<denite:scroll_page_forwards>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'insert',
"      \ '<C-p>',
"      \ '<denite:print_messages>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ '<C-j>',
"      \ '<denite:wincmd:j>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ '<C-k>',
"      \ '<denite:wincmd:k>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ '<esc>',
"      \ '<denite:quit>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'a',
"      \ '<denite:do_action:add>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'd',
"      \ '<denite:do_action:delete>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'r',
"      \ '<denite:do_action:reset>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 's',
"      \ '<denite:do_action:vsplit>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'e',
"      \ '<denite:do_action:edit>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'h',
"      \ '<denite:do_action:help>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'u',
"      \ '<denite:do_action:update>',
"      \ 'noremap'
"      \)
"
"call denite#custom#map(
"      \ 'normal',
"      \ 'f',
"      \ '<denite:do_action:find>',
"      \ 'noremap'
"\)

" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
            \ [ "&New File", ':enew' ],
            \ [ "&Open File", ':CtrlP' ],
            \ [ "&Close", ':q' ],
            \ [ "--", '' ],
            \ [ "&Save", ':w'],
            \ [ "Save &All", ':wa' ],
            \ [ "--", '' ],
            \ [ "E&xit", ':qa' ],
            \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Code", [
            \ ["Show &Errors", 'lopen'],
            \ ["&Next Error", 'ALENext'],
            \ ["&Previous Error", 'ALEPrevious'],
            \ ["GoTo &Definition", 'execute "normal \<Plug>(coc-definition)"'],
            \ ["GoTo &Type Definition", 'execute "normal \<Plug>(coc-type-definition)"'],
            \ ["GoTo &Implementation", 'execute "normal \<Plug>(coc-implementation)"'],
            \ ["Show &References", 'execute "normal \<Plug>(coc-references)"'],
            \ ["Rename &Symbol", 'execute "normal \<Plug>(coc-rename)"'],
            \ ["S&ort Imports", "call CocAction('runCommand', 'editor.action.organizeImport')"],
            \ ])

call quickui#menu#install("&Option", [
            \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
            \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
            \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
            \ ["&Rainbow Parens", 'RainbowToggle'],
            \ ])

call quickui#menu#install("&Tools", [
            \ ["&Gundo Tree", 'MundoToggle'],
            \ ["&Undo Tree", 'UndotreeToggle'],
            \ ["&Tagbar", 'TagbarToggle'],
            \ ["Tag&list", 'TlistToggle'],
            \ ["&Vista Taglist", 'TlistToggle'],
            \ ["&Dateien", 'TlistToggle'],
            \ ["&Calendar", 'CalendarH'],
            \ ])

call quickui#menu#install("&Git", [
            \ ["&Status", 'Gstatus'],
            \ ["&History", 'GV'],
            \ ["&Branches", 'Twiggy'],
            \ ["&Complex Branches", 'Merginal'],
            \ ["Blame &Line", 'execute "normal \<Plug>(git-messenger)"'],
            \ ["Bl&ame", 'Gblame'],
            \ ])

call quickui#menu#install("&VCS", [
            \ ["&Status", 'VCStatus'],
            \ ["&Add", 'VCAdd'],
            \ ["Add This &File", 'VCSAdd'],
            \ ["&Commit This File", 'VCSCommit'],
            \ ["&Diff to Head", 'VCSDiff'],
            \ ["&Blame", 'VCBlame'],
            \ ["&Log", 'VCSLog'],
            \ ["Repo &Info", 'VCInfo'],
            \ ])


" register HELP menu with weight 1000
call quickui#menu#install('H&elp', [
            \ ["&Cheatsheet", 'help index', ''],
            \ ['T&ips', 'help tips', ''],
            \ ['--',''],
            \ ["&Tutorial", 'help tutor', ''],
            \ ['&Quick Reference', 'help quickref', ''],
            \ ['&Summary', 'help summary', ''],
            \ ], 10000)

" enable to display tips in the cmdline
let g:quickui_show_tip = 1
let g:quickui_border_style = 3
"let g:quickui_color_scheme = 'papercol light'

" hit space twice to open menu
noremap <silent> <M-m> :call quickui#menu#open()<cr>
noremap <silent> µ :call quickui#menu#open()<cr>

" Additional helper mappings
nmap <leader>jf :NERDTreeFind<cr>
nmap <leader>js :Git<cr>
nmap <leader>jgp :Git push<cr>
nmap <leader>jgc :Git commit -avs<cr>
nmap <leader>jgr :Git pull --rebase<cr>
nmap <leader>jt :Twiggy<cr>
nmap <leader>jl :GV<cr>

if has('nvim')
let g:nvim_tree_indent_markers = 0
let g:nvim_tree_gitignore = 0
let g:nvim_tree_git_hl = 0
let g:nvim_tree_highlight_opened_files = 3
let g:nvim_tree_group_empty = 0
let g:nvim_tree_show_icons = {
\ 'git': 1,
\ 'folders': 1,
\ 'files': 1,
\ 'folder_arrows': 1,
\ }
let g:nvim_tree_icons = {
    \ 'default':        '',
    \ 'symlink':        '',
    \ 'git': {
    \   'unstaged':     "",
    \   'staged':       "✓",
    \   'unmerged':     "",
    \   'renamed':      "➜",
    \   'untracked':    "★",
    \   'deleted':      "",
    \  },
    \ 'folder': {
    \   'arrow_open':   "",
    \   'arrow_closed': "",
    \   'default':      "",
    \   'open':         "",
    \   'empty':        "",
    \   'empty_open':   "",
    \   'symlink':      "",
    \   'symlink_open': "",
    \  },
    \  'lsp': {
    \    'hint': "",
    \    'info': "",
    \    'warning': "",
    \    'error': "",
    \  }
    \ }
"lua <<EOF
"require'nvim-tree'.setup{
"    filters = {
"        dotfiles = true,
"        custom = {"~"}
"        }
"    }
"EOF

lua require('lsp-virtual-improved').setup()
lua require('url-open').setup()
lua require('CopilotChat').setup({ mode = "split", debug = false })

"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = {
"    "python",
"    "markdown",
"    "bash",
"    "c",
"    "cpp",
"    "css",
"    "html",
"    "java",
"    "json",
"    "toml",
"    "yaml"
"    },     -- one of "all", "language", or a list of languages
"  highlight = {
"    enable = true,  -- false will disable the whole extension
"  },
"    refactor = {
"    highlight_definitions = { enable = true },
"  },
"}
"EOF
lua <<EOF
require("dap").adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode-10", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = function()
		return vim.fn.input(
			"Args: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	runInTerminal = true,
	  initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
}

require('dap').configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}
require("dapui").setup()

EOF
endif
