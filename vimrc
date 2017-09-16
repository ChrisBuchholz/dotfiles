" vundle ---------------------------------------------------------------------


if &compatible
  set nocompatible
endif

filetype off

call plug#begin('~/.vim/plugged')

Plug 'rking/ag.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'int3/vim-extradite'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'keith/swift.vim'
Plug 'mattn/webapi-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cespare/vim-toml'
Plug 'exu/pgsql.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
Plug 'jgdavey/tslime.vim'
Plug 'vim-syntastic/syntastic'
Plug 'Valloric/ListToggle'
Plug 'pearofducks/ansible-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'stephpy/vim-yaml'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()


" basic ----------------------------------------------------------------------


filetype plugin indent on

set shell=/bin/bash
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set clipboard=unnamed
set matchpairs+=<:>
set hidden
set hlsearch
set backupskip=/tmp/*,/private/tmp/*"
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set noswapfile
set completeopt-=preview
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set ignorecase
set incsearch
set laststatus=2
set nottimeout
set ttimeoutlen=50
set backspace=indent,eol,start

let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'
let mapleader = "\<Space>"
let g:sql_type_default = 'pgsql'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>qq'
let g:gitgutter_sign_column_always = 1
set grepprg=ag\ --nogroup\ --nocolor

" dont use expandtab in make files
au FileType make set noexpandtab

" restore cursor position
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$")
        \ && &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif

" crontab
au filetype crontab setlocal nobackup nowritebackup

let g:vim_markdown_folding_disabled = 1

let g:alchemist_tag_disable = 1

let g:deoplete#enable_at_startup = 1


" Theme ----------------------------------------------------------------------


colorscheme molokai

set background=dark
set fillchars+=vert:\|
set cc=+1

let g:molokai_original = 1
let g:rehash256 = 1
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_theme='badwolf'
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#neomake#enabled = 1

syntax enable on

hi VertSplit cterm=NONE ctermbg=236 ctermfg=236


" Maps -----------------------------------------------------------------------


nnoremap <silent> <leader>g :GundoToggle<cr>
nnoremap <esc> :noh<return><esc>
nmap <leader>s <Plug>SetTmuxVars


" NerdTree -------------------------------------------------------------------


nnoremap <silent> <leader>f :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.DS_Store$']
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 24
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "@",
    \ "Renamed"   : "-",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "-",
    \ "Clean"     : "o",
    \ "Unknown"   : "?"
    \ }


" Text bubbling - thank you Tim Pope! ----------------------------------------


nnoremap <S-h> <<
nmap <S-j> ]e
nmap <S-k> [e
nnoremap <S-l> >>
vnoremap <S-h> <<CR>gv
vmap <S-j> ]egv
vmap <S-k> [egv
vnoremap <S-l> ><CR>gv


" Syntastic ------------------------------------------------------------------


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Rust -----------------------------------------------------------------------


let g:syntastic_enable_rust_checker = 0
let g:rustfmt_autosave = 1
let g:racer_cmd = '/Users/cb/tmp/racer/target/release/racer'
let g:racer_experimental_completer = 1
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

function! neomake#makers#cargo#cargo() abort
    return {
        \ 'args': ['check'],
        \ 'errorformat':
            \ neomake#makers#ft#rust#rustc()['errorformat'],
        \ }
endfunction

if filereadable(getcwd()."/Cargo.toml")
    "au BufReadPre,BufWritePost *.rs Neomake! cargo
    au FileType rust nmap <leader>r :Tmux cargo run<CR>
    au FileType rust nmap <leader>u :Tmux cargo test<CR>
    au FileType rust nmap <leader>b :Tmux cargo build<CR>
    au FileType rust nmap <leader>c :Tmux cargo clean<CR>
else
    "au BufReadPre,BufWritePost *.rs Neomake
    au FileType rust nmap <leader>r :execute
        \ ":Tmux cargo script ".expand("%")<CR>
endif

au FileType rust nmap <leader>. :call Send_keys_to_Tmux('C-c')<CR>
au FileType rust nmap <leader>, :call Send_keys_to_Tmux('Up Enter')<CR>


" Swift ----------------------------------------------------------------------


let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

if filereadable(getcwd()."/Package.swift")
    au FileType swift nmap <leader>r :execute ":Tmux swiftrun"<CR>
    au FileType swift nmap <leader>u :Tmux swift test<CR>
    au FileType swift nmap <leader>b :Tmux swift build<CR>
    au FileType swift nmap <leader>c :Tmux swift build --clean<CR>
else
    au FileType swift nmap <leader>r :execute ":Tmux swift ".expand("%")<CR>
end

au FileType swift nmap <leader>. :call Send_keys_to_Tmux('C-c')<CR>
au FileType swift nmap <leader>, :call Send_keys_to_Tmux('Up Enter')<CR>


" Elixir ---------------------------------------------------------------------


if filereadable(getcwd()."/mix.exs")
    au FileType elixir nmap <leader>r :execute ":Tmux mix "<CR>
    au FileType elixir nmap <leader>b :execute ":Tmux mix compile"<CR>
    au FileType elixir nmap <leader>u :execute ":Tmux mix test"<CR>
else
    au FileType elixir nmap <leader>r :execute ":Tmux elixir ".expand("%")<CR>
    au FileType elixir nmap <leader>b :execute ":Tmux elixirc ".expand("%")<CR>
end

au FileType elixir nmap <leader>. :call Send_keys_to_Tmux('C-c')<CR>
au FileType elixir nmap <leader>, :call Send_keys_to_Tmux('Up Enter')<CR>

"au FileType elixir BufReadPre,BufWritePost * Neomake


" Python ---------------------------------------------------------------------


let g:syntastic_enable_python_checker = 0
"let g:neomake_python_flake8_maker = {
    "\ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
    "\ 'errorformat':
        "\ '%E%f:%l: could not compile,%-Z%p^,' .
        "\ '%A%f:%l:%c: %t%n %m,' .
        "\ '%A%f:%l: %t%n %m,' .
        "\ '%-G%.%#',
    "\ }
"let g:neomake_python_enabled_makers = ['flake8']

au FileType python set textwidth=79
"au BufReadPre,BufWritePost *.py Neomake


" FZF ------------------------------------------------------------------------


let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~20%' }
map <leader>o :FZF<cr>


" go to definition -----------------------------------------------------------


nnoremap <C-g> <C-]>
nnoremap <C-x> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <C-s> :sp <cr>:exec("tag ".expand("<cword>"))<cr>
au FileType rust map <C-g> gd
au FileType rust map <C-x> gx
au FileType rust map <C-s> gs


" tags -----------------------------------------------------------------------


nmap <leader>t :TagbarToggle<CR>
let g:gutentags_cache_dir = '~/.tags/'


" expand color column - must be done as the last thing -----------------------


au FileType * execute "set cc=+".join(range(1, 200), ',+')
