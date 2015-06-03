set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'int3/vim-extradite'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'sjl/gundo.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-unimpaired'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'klen/python-mode'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

" shell
set shell=/bin/sh

" credentials
let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'

" preferences
syntax sync fromstart

let mapleader = "\<Space>"
let maplocalleader = "\\"
noremap \ ,

" Theme -----------------------------------------------------------------------

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

" Airline ---------------------------------------------------------------------

let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_theme='badwolf'

" Stuff -----------------------------------------------------------------------

set ts=4 sw=4 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 24

set list
set listchars=tab:▸\ ,eol:\ ,extends:❯,precedes:❮
set number
set numberwidth=5
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
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set colorcolumn=80
set clipboard=unnamed
set wildmenu

nnoremap <silent> <leader>f :NERDTreeToggle<CR>

nnoremap 0 ^

nnoremap <Leader>w :w<CR>

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"Save when losing focus
au FocusLost * :wa

"Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

if has("gui_running")
     "disable toolbar, menubar, scrollbars
    set guioptions=aiA " Disable toolbar, menu bar, scroll bars
     "hide mouse when typing
    "set mousehide
     "window size
    set lines=35 columns=110
     "font
    set guifont=Source\ Code\ Pro:h11
endif

if has("gui_macvim")
     "set macvim specific stuff
     "max horizontal height of window
    set fuopt+=maxhorz
endif

if has("title")
    set title
endif

if has("title") && (has("gui_running") || &title)
    set titlestring=
    set titlestring+=%f\ " file name
    set titlestring+=%h%m%r%w
    set titlestring+=\ -\ %{v:progname}
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

"switch syntax highlighting on when terminal has colors
"also switch on highlighting the last used search pattern
"and set proper typeface
if &t_Co > 2 || has('gui_running')
    syntax on
endif

"autocommands!
autocmd FileType make set noexpandtab

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"tagbar settings
nnoremap <silent> <leader>b :TagbarToggle<CR>

":make
nnoremap <silent> <leader>m :w<CR>:make<CR>:cw<CR>

"text bubbling - using Tim Pope's unimpaired plugin
nnoremap <S-h> <<
nmap <S-j> ]e
nmap <S-k> [e
nnoremap <S-l> >>
vnoremap <S-h> <<CR>gv
vmap <S-j> ]egv
vmap <S-k> [egv
vnoremap <S-l> ><CR>gv

"escape insert mode instantly
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

"remove trailing whitespace on buffer write
autocmd BufWritePre * :%s/\s\+$//e

"diff unsaved changes to file
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

 "rebind join since we're using c-j for navigation
vmap <C-S-j> :join<CR>

"tags -------------------------------------------------------------------------

set tags=./.tags;/
let g:easytags_dynamic_files = 1
let g:easytags_async = 1

let g:easytags_languages = {
\   'haskell': {
\       'cmd': '~/.cabal/bin/hasktags',
\       'args': ['-c'],
\       'fileoutput_opt': '-o',
\       'stdout_opt': '-f-',
\       'recurse_flag': '.'
\   }
\}

 "go to definition
nnoremap <C-g> <C-]>
nnoremap <C-s> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
"nnoremap <C-s> :sp <cr>:exec("tag ".expand("<cword>"))<cr>

" Python ----------------------------------------------------------------------
let g:pymode_rope = 1
let g:pymode_rope_goto_definition_bind = "<C-g>"

"CtrlP ------------------------------------------------------------------------

let g:ctrlp_map = '<Leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
nnoremap <silent> <Leader>t :CtrlPTag<cr>
nnoremap <silent> <Leader>r :CtrlPMRU<cr>

"Gundo ------------------------------------------------------------------------

nnoremap <silent> <leader>u :GundoToggle<cr>

"Ruby ------------------------------------------------------------------------

autocmd Filetype ruby set shiftwidth=2
autocmd Filetype ruby set tabstop=2
autocmd Filetype ruby set softtabstop=2

"Crontab ----------------------------------------------------------------------

autocmd filetype crontab setlocal nobackup nowritebackup

"XML prettifier ---------------------------------------------------------------

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

"Set PWD to current file -----------------------------------------------------

function! DoUpdatePWDToCurrentFile()
    cd %:p:h
endfunction
command! UpdatePWDToCurrentFile call DoUpdatePWDToCurrentFile()
