augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" neovim stuff
if has('nvim')
    let g:python2_host_prog = '/usr/bin/python'
    set termguicolors
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
Plug 'dyng/ctrlsf.vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'
Plug 'thinca/vim-visualstar'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

"Plug 'vim-vdebug/vdebug'
"Plug 'editorconfig/editorconfig-vim'

" Color Schemes
Plug 'vim-scripts/moria'
Plug 'vim-scripts/Solarized'
Plug 'vim-scripts/sonoma.vim'
Plug 'vim-scripts/peaksea'
Plug 'gosukiwi/vim-atom-dark'
Plug 'vim-scripts/desertEx'
Plug 'toupeira/vim-desertink'
Plug 'hewo/vim-colorscheme-deepsea'
Plug 'hachy/eva01.vim'
Plug 'whatyouhide/vim-gotham'
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'gregsexton/Muon'
Plug 'jnurmine/Zenburn'
Plug 'Wutzara/vim-materialtheme'
Plug 'junegunn/seoul256.vim'
Plug 'romainl/Apprentice'
Plug 'benburrill/potato-colors'
Plug 'liuchengxu/space-vim-theme'
Plug 'rakr/vim-one'
Plug 'kabbamine/yowish.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'freeo/vim-kalisi'
Plug 'NLKNguyen/papercolor-theme'

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

if !has('nvim')
    set ttymouse=sgr        " Resize splits inside tmux
endif


" Arbeit

set backup
set backupdir=/tmp,.
set directory=/tmp,.
set diffexpr=
""set guifont=Courier_New:h10:cANSI
set guifont=Liberation\ Mono\ 10
set helplang=de
set history=1000
set keymodel=startsel,stopsel
set ruler
set selection=inclusive
set updatetime=5000
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
set pastetoggle=<F10>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDtree
"Plug 'vim-scripts/The-NERD-tree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=2
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=0
let g:NERDTreeDirArrows = 0
let NERDTreeCascadeSingleChildDir=0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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
Plug 'gregsexton/gitv', {'on': ['Gitv']}

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
nnoremap <Leader>b :CtrlPBuffer<cr>
nnoremap <Leader>g :CtrlPBuffer<cr>
nnoremap <Leader>m :CtrlPMRUFiles<cr>
nnoremap <Leader>t :CtrlPTag<cr>
nnoremap <Leader>f :CtrlPFunky<cr>
nnoremap <Leader>l :CtrlPLine<cr>

" Ale """""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 0
let g:ale_set_balloons = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_java_javac_classpath = '/home/steven/bin/android/sdk/platforms/android-28/android.jar'
let b:ale_fixers = ['autopep8', 'yapf']

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

" CoC """""""""""""""""""
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"autocmd CursorHold * silent call CocActionAsync('highlight')
"nmap <leader>d <Plug>(coc-definition)
"nmap <leader>a <Plug>(coc-codeaction)
"nmap <leader>e <Plug>(coc-codelens-action)
"nmap <leader>r <Plug>(coc-refactor)

" completor """""""""""""""""""
"Plug 'maralla/completor.vim'
"let g:completor_complete_options = 'menuone,noselect'

" Deoplete """""""""""""""""""
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'ncm2/float-preview.nvim'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-jedi'

Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neco-syntax'
Plug 'wellle/tmux-complete.vim'
"Plug 'ujihisa/neco-look'
let g:deoplete#enable_at_startup = 1
"
" floating window
let g:float_preview#docked = 0
let g:float_preview#max_width = 100
let g:deoplete#sources#jedi#show_docstring = 1

" Use smartcase.
"call deoplete#custom#option('smart_case', v:true)
set completeopt-=preview
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

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
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
""let g:UltiSnipsJumpBackwardTrigger="<c-K>"
let g:ultisnips_python_style = 'google'
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
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" easyalign """"""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
Plug 'davidhalter/jedi-vim' " aus wenn coc
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

" Word highlight """""""""""""""""""""""""""""""
Plug 't9md/vim-quickhl'
nmap <leader>v <Plug>(quickhl-manual-this)
xmap <leader>v <Plug>(quickhl-manual-this)
nmap <leader>V <Plug>(quickhl-manual-reset)
xmap <leader>V <Plug>(quickhl-manual-reset)

" Emmet """""""""""""""""""""""""""""""
Plug 'mattn/emmet-vim'
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
"let g:airline#extensions#tabline#left_sep = '▶'
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '#'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#eclim#enabled = 1

set laststatus=2 " always have a statusline

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
set background=dark
color gruvbox
hi link ALEErrorSign    Error
hi link ALEWarningSign  Keyword
highlight ColorColumn guibg=gray20
highlight ColorColumn ctermbg=236
hi VertSplit ctermbg=bg cterm=none
hi SignColumn ctermbg=none
set fillchars=vert:\│,fold:-

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
