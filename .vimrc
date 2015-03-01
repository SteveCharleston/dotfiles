augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" let Vundle manage Vundle
"set rtp=$VIMRUNTIME,~/.vim/bundle/vundle/ 
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#rc()
"call vundle#begin()
"
call plug#begin('~/.vim/bundle')
"Plug 'gmarik/Vundle.vim'
"Plugin 'gmarik/vundle'

"Plugin 'code_complete'
Plug 'Indent-Guides'
Plug 'ref.vim'
Plug 'trinity.vim'
Plug 'Gundo'
Plug 'Finder-for-vim'
Plug 'Mark-Ring'
Plug 'rainbow_parentheses.vim'
Plug 'reorder-columns'
Plug 'visual-increment'
Plug 'Peasy'
Plug 'Python-2.x-Standard-Library-Reference'
Plug 'swap'
Plug 'htmlspecialchars'
Plug 'EasyGrep'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/vimproc'
Plug 'javacomplete'
Plug 'ragtag.vim'
Plug 'Syntastic'
Plug 'closetag.vim'
Plug 'surround.vim'
Plug 'repeat.vim'
Plug 'xolox/vim-misc'
"Plug 'easytags.vim'
"Plug 'session.vim'
Plug 'vcscommand.vim'
"Plug 'ShowMarks'
Plug 'The-NERD-Commenter'
Plug 'vim-perl/vim-perl'
"Plug 'ctrlp.vim'
Plug 'paranoida/vim-airlineish'
Plug 'dansomething/vim-eclim'
Plug 'https://github.com/jaxbot/browserlink.vim'
"Plug 'skammer/vim-css-color'
"Plug 'Valloric/YouCompleteMe'

" Color Schemes
Plug 'moria'
Plug 'Solarized'
Plug 'sonoma.vim'
Plug 'peaksea'

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
set ttymouse=xterm2     " Resize splits inside tmux
set sw=4		" space indentation wide 4
set hlsearch		" Highlight search items
set incsearch		" Incremental search, start searching as soon as I type
set number		" Show Line Numbers
set noautochdir           " always switch to the current file directory 
set hidden              " change buffers without saving
""set title               " Let vim set the xterm title
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
set listchars=tab:>.,trail:.,extends:#,nbsp:. " make special chars visible
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set backspace=indent,eol,start " make backspace a more flexible
set completeopt=menu,preview " display the completition menu and a preview window
set softtabstop=4 shiftwidth=4 expandtab 
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,preview
set guioptions=ci
set tags=./tags;


" Arbeit

set backup
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

" load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

" Enable extendet % matching
runtime macros/matchit.vim
" Read man pages with vim
runtime! ftplugin/man.vim

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

" Faster Scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

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
" vim-session """"""""""""""""""""""""""""""""""""""""
Plug 'xolox/vim-session'
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_autoload_periodic=1

" NERDtree
Plug 'The-NERD-tree'
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=2
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrows = 0

" Buffersaurus """"""""""""""""""""""""""""""""""""""""
" Searches in open Buffers
" :Bsgrep - Searches for given Regex
" :Bstoc - lists table of content for buffers
" :Bsreplace - global search and replace
Plug 'Buffersaurus'


" Tag list """"""""""""""""""""""""""""""""""""""""
Plug 'taglist.vim'
let Tlist_Auto_Open=0	" Automatically Open the Tag List
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself 


" SrcExplorer """""""""""""""""""""""""""""""""""""
Plug 'Source-Explorer-srcexpl.vim'
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer",
        \ "-MiniBufExplorer-"
    \ ] 

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100 

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1 



" Tagbar     """"""""""""""""""""""""""""""""""""""
Plug 'Tagbar'
let g:tagbar_left=0
let g:tagbar_singleclick=1


" Conque Term """""""""""""""""""""""""""""""""""""
Plug 'basepi/vim-conque'
let g:ConqueTerm_Color = 1
let g:ConqueTerm_SessionSupport = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_PromptRegex = '^\w\+@[0-9A-Za-z_.-]\+:[0-9A-Za-z_./\~,:-]\+\$'
let g:ConqueTerm_Syntax = 'conque'


" Unite  """""""""""""""""""""""""""""""""""
Plug 'unite.vim'
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1

nnoremap <C-P> :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:!<cr>
"nnoremap <C-O> :<C-u>Unite -buffer-name=files -start-insert buffer<cr>
nnoremap yr :Unite history/yank<cr>

" Neocomplcache """""""""""""""""""""""""""""""""""
if has("lua")
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    "let g:neocomplete_min_syntax_length = 0

    " Plugin key-mappings.
    " <CR>: close popup
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    "imap <expr><TAB> neocomplete#sources#snippets_complete#expandable() ? "\<Plug>(neocomplete_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    "

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
    " SuperTab like snippets behavior.
    "imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    "\ "\<Plug>(neosnippet_expand_or_jump)"
    "\: pumvisible() ? "\<C-n>" : "\<TAB>"
    "smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    "\ "\<Plug>(neosnippet_expand_or_jump)"
    "\: "\<TAB>"

    "imap  <silent><expr><tab>  neocomplete#sources#snippets_complete#expandable() ? "\<plug>(neocomplete_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
    smap  <tab>  <right><plug>(neocomplete_snippets_jump) 
    inoremap <expr><c-e>     neocomplete#complete_common_string()

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
else
    let g:neocomplcache_enable_at_startup = 1
    "let g:neocomplcache_min_syntax_length = 0

    " Plugin key-mappings.
    " <CR>: close popup
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction

    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    "

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
    " SuperTab like snippets behavior.
    "imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    "\ "\<Plug>(neosnippet_expand_or_jump)"
    "\: pumvisible() ? "\<C-n>" : "\<TAB>"
    "smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    "\ "\<Plug>(neosnippet_expand_or_jump)"
    "\: "\<TAB>"

    "imap  <silent><expr><tab>  neocomplcache#sources#snippets_complete#expandable() ? "\<plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
    smap  <tab>  <right><plug>(neocomplcache_snippets_jump) 
    inoremap <expr><c-e>     neocomplcache#complete_common_string()
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neocomplete#force_overwrite_completefunc=1

" EasyMotion """"""""""""""""""""""""""""""""""
"Plugin 'EasyMotion'
"nnoremap <Space> H:call EasyMotion#F(0, 0)<CR>
Plug 'Lokaltog/vim-easymotion'
nmap <Space> <Plug>(easymotion-bd-f)
nmap <Space><Space> <Plug>(easymotion-jumptoanywhere)
nmap <Leader>w <Plug>(easymotion-jumptoanywhere)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'


" TabBar """"""""""""""""""""""""""""""""""
""Plugin 'TabBar'
""let g:Tb_MaxSize = 1
""let g:Tb_UseSingleClick = 1


" Slimux """""""""""""""""""""""""""""""""""""
Plug 'epeli/slimux'
map <C-c><C-c> :SlimuxREPLSendLine<CR>
vmap <C-c><C-c> :SlimuxREPLSendSelection<CR>

" YankRing """""""""""""""""""""""""""""""""""""
"Plugin 'YankRing.vim'
"map yr :YRShow<CR>

" Snippets """""""""""""""""""""""""""""""""""""
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
""let g:UltiSnipsJumpForwardTrigger="<c-k>"
""let g:UltiSnipsJumpBackwardTrigger="<c-K>"
"
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

" jedi-vim """""""""""""""""""""""""""""""""""""
Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

" perl.vim """""""""""""""""""""""""""""""""""""
Plug 'perl.vim'
let perl_include_pod = 1
let perl_extended_vars = 1
"Plugin 'perl-support.vim'
"Plugin 'vim-perl'

" Emmet """""""""""""""""""""""""""""""
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-m>'

" Quickfixsigns """""""""""""""""""""""""""""""""""""
Plug 'tomtom/quickfixsigns_vim'
let g:quickfixsigns_classes = ['loc', 'qfl', 'marks', 'breakpoints']

" minibufexpl """""""""""""""""""""""""""""""""""""
Plug 'techlivezheng/vim-plugin-minibufexpl'
" switching to buffer 1 - 9 is mapped to ,[nOfBuffer]
for buffer_no in range(1, 9)
  execute "nmap <A-" . buffer_no . "> :b" . buffer_no . "\<CR>"
endfor

" switching to buffer 10 - 100 is mapped to ,0[nOfBuffer]
for buffer_no in range(10, 100)
  execute "nmap <A-0" . buffer_no . "> :b" . buffer_no . "\<CR>"
endfor

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

" Airline + Tabline """""""""""""""""""""""""""""
Plug 'bling/vim-airline'
"Plugin 'mkitt/tabline.vim'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme = 'airlineish'

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'

set laststatus=2 " always have a statusline

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#excludes = []
"let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
"let g:airline#extensions#tabline#buffer_nr_show = 1
"
"let g:airline#extensions#syntastic#enabled = 1
"let g:airline#extensions#tagbar#enabled = 1
"map <M-1> :b1<CR>
"map <M-2> :b2<CR>
"map <M-3> :b3<CR>
"map <M-4> :b4<CR>
"map <M-5> :b5<CR>
"map <M-6> :b6<CR>
"map <M-7> :b7<CR>
"map <M-8> :b8<CR>
"map <M-9> :b9<CR>
"map <M-0> :b0<CR>
"map <C-Tab> :bnext<CR>
"map <C-S-Tab> :bprevious<CR>
map <C-Tab> :MBEbn<CR>
map <C-S-Tab> :MBEbp<CR>

"Uninstalled
"Plugin 'snipmate-snippets'
"Plugin 'HTML-AutoCloseTag'
"Plugin 'AutoComplPop'
"Plugin 'snipMate'
"Plugin 'AutoClose'
"Plugin 'autosess'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'PyScratch'
"Plugin 'PyInteractive''
"Plugin 'shell.vim'
"Plugin 'backup.vim'
"Plugin 'session.vim'
"Plugin 'eclim'
"apachelogs.vim
"Plugin 'Align'
""Plugin 'Lokaltog/vim-powerline'
""Plugin 'neocomplcache-snippets_complete'
""Plugin 'pydoc.vim'

" Auto-Pairs  """""""""""""""""""""""""""""""""""""
""Plugin 'Auto-Pairs'
""let g:AutoPairsFlyMode = 1
call plug#end()
"call vundle#end()            " required

color peaksea
highlight ColorColumn guibg=gray86
highlight ColorColumn ctermbg=253
