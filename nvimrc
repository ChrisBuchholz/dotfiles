call plug#begin('~/.vim/plugged')

Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/tomasr/molokai.git'

call plug#end()

set background=dark
colorscheme molokai
let g:molokai_original = 0
let g:rehash256 = 1

let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'

syntax sync fromstart

let mapleader = ","
let maplocalleader = "\\"

set ts=4 sw=4 et

set list
set listchars=tab:▸\ ,eol:\ ,extends:❯,precedes:❮
set number
set numberwidth=5
set cursorline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hidden
set scrolloff=3
set vb t_vb=
set showmatch
set matchpairs+=<:>
set matchtime=3
set wrap
set linebreak
set autoindent
set smartindent
set nowrap
set ignorecase
set smartcase
set nolazyredraw
set encoding=utf8
set fileencoding=utf8
set fileformat=unix
set backspace=indent,eol,start
set history=1000
set ruler
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " this is just what i use
set showcmd
set incsearch
set laststatus=2
set backupskip=/tmp/*,/private/tmp/*"
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set noswapfile
set completeopt-=preview

" persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" CtrlP -----------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
nnoremap <silent> <leader>t :CtrlPTag<cr>
nnoremap <silent> <leader>r :CtrlPMRU<cr>

" Clipboard stuff for os x --------------------------------------

function! ClipboardYank()
	call system('pbcopy', @@)
endfunction

function! ClipboardPaste()
	let @@ = system('pbpaste')
endfunction

"vnoremap <silent> y y:call ClipboardYank()<cr>
"vnoremap <silent> d d:call ClipboardYank()<cr>
"nnoremap <silent> p :call ClipboardPaste()<cr>p
