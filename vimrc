set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
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

call vundle#end()
filetype plugin indent on


" Theme -----------------------------------------------------------------------


colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_theme='badwolf'


" Stuff -----------------------------------------------------------------------


set shell=/bin/bash
let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'
syntax sync fromstart
let mapleader = "\<Space>"
let maplocalleader = "\\"
noremap \ ,
set viminfo='10,\"100,:20,%,n~/.viminfo
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
set list
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hidden
set scrolloff=3
set vb t_vb=
set showmatch
set cursorline
set matchpairs+=<:>
set matchtime=3
set linebreak
set autoindent
set smartindent
set nowrap
set ignorecase
set smartcase
set encoding=utf8
set fileencoding=utf8
set fileformat=unix
set backspace=2
set history=1000
set ruler
set showcmd
set incsearch
set laststatus=2
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
set colorcolumn=80
set clipboard=unnamed
set wildmenu
syntax on
set guioptions=aiA " Disable toolbar, menu bar, scroll bars
set lines=35 columns=110
set fuopt+=maxhorz

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:\ ,extends:>,precedes:<,nbsp:+
endif

" save changes when focus is lost
au FocusLost * :wa
" resize buffers when window size changes
au VimResized * exe "normal! \<c-w>="
" dont use expandtab in make files
au FileType make set noexpandtab
" restore cursor position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" | exe("normal `\"") | endif
" remove trailing whitespace on buffer write
au BufWritePre * :%s/\s\+$//e
" crontab
autocmd filetype crontab setlocal nobackup nowritebackup

let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 24
nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap 0 ^
nnoremap <Leader>w :w<CR>
nnoremap <silent> <leader>m :w<CR>:make<CR>:cw<CR>
nnoremap <silent> <leader>u :GundoToggle<cr>

" text bubbling - using Tim Pope's unimpaired plugin
nnoremap <S-h> <<
nmap <S-j> ]e
nmap <S-k> [e
nnoremap <S-l> >>
vnoremap <S-h> <<CR>gv
vmap <S-j> ]egv
vmap <S-k> [egv
vnoremap <S-l> ><CR>gv

" escape insert mode instantly
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" diff unsaved changes to file
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif


" tags ------------------------------------------------------------------------


set tags=./.tags;/
let g:easytags_dynamic_files = 1
let g:easytags_async = 1


" go to definition ------------------------------------------------------------


nnoremap <C-g> <C-]>
nnoremap <C-s> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
"nnoremap <C-s> :sp <cr>:exec("tag ".expand("<cword>"))<cr>


" Python ----------------------------------------------------------------------


let g:syntastic_python_checkers = ['flake8']


" CtrlP ------------------------------------------------------------------------


let g:ctrlp_map = '<Leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
nnoremap <silent> <Leader>t :CtrlPTag<cr>
nnoremap <silent> <Leader>r :CtrlPMRU<cr>


" XML prettifier ---------------------------------------------------------------


function! DoPrettyXML()
   "save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
   "delete the xml header if it exists. This will
   "permit us to surround the document with fake tags
   "without creating invalid xml.
  1s/<?xml .*?>//e
   "insert fake tags around the entire document.
   "This will permit us to pretty-format excerpts of
   "XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
   "xmllint will insert an <?xml?> header. it's easy enough to delete
   "if you don't want it.
   "delete the fake tags
  2d
  $d
   "restore the 'normal' indentation, which is one extra level
   "too deep due to the extra tags we wrapped around the document.
  silent %<
   "back to home
  1
   "restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()


" The Silver Searcher ---------------------------------------------------------


if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
