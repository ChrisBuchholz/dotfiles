" vundle ---------------------------------------------------------------------


if &compatible
  set nocompatible
endif

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/fzf'
Plugin 'int3/vim-extradite'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-unimpaired'
Plugin 'xolox/vim-misc'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'apple/swift', {'rtp': 'utils/vim/'}
Plugin 'mattn/webapi-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cespare/vim-toml'
Plugin 'exu/pgsql.vim'

call vundle#end()


" basic ----------------------------------------------------------------------


filetype plugin indent on

set shell=/bin/bash
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hidden
set cursorline
set nottimeout
set clipboard=unnamed
set matchpairs+=<:>
set ignorecase
set incsearch
set laststatus=2
set ttimeoutlen=50

let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'
let mapleader = "\<Space>"
let g:sql_type_default = 'pgsql'

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

syntax enable on

hi VertSplit cterm=NONE ctermbg=236 ctermfg=236 guibg=236 guifg=236


" Maps -----------------------------------------------------------------------


nnoremap <silent> <leader>u :GundoToggle<cr>
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[


" NerdTree -------------------------------------------------------------------


nnoremap <silent> <leader>f :NERDTreeToggle<CR>
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


" FZF ------------------------------------------------------------------------


let g:fzf_history_dir = '~/.local/share/fzf-history'

map <leader>o :FZF<cr>
