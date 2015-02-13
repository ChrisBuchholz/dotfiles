set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'craigemery/vim-autotag'
Plugin 'bkad/CamelCaseMotion'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'kien/ctrlp.vim'
Plugin 'int3/vim-extradite'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-haml'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'walm/jshint.vim'
Plugin 'tomasr/molokai'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-unimpaired'

call vundle#end()
filetype plugin indent on

" shell
set shell=/bin/sh

" credentials
let g:name = 'Christoffer Buchholz'
let g:email = 'chris@chrisbuchholz.me'

" preferences
syntax sync fromstart

let mapleader = ","
let maplocalleader = "\\"

" Theme -----------------------------------------------------------------------

set background=dark
colorscheme molokai
let g:molokai_original = 0
let g:rehash256 = 1

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

nnoremap <silent> <leader>f :NERDTreeToggle<CR>

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

nnoremap 0 ^

" clear search
nnoremap <esc> :noh<return><esc>

" persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" colorcolumn
set colorcolumn=80

" use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" enhance command-line completion
set wildmenu

" spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

" <Ctrl-l> redraws the screen and removes any search highlighting.
"nnoremap <silent> <C-l> :nohl<CR><C-l>

" in most terminal emulators, the mouse works fine, so enable it!
if has('mouse')
    set mouse=a
    set ttymouse=xterm2
endif

if has("gui_running")
    " disable toolbar, menubar, scrollbars
    set guioptions=aiA " Disable toolbar, menu bar, scroll bars
    " hide mouse when typing
    set mousehide
    " window size
    set lines=35 columns=110
    " font
    set guifont=Source\ Code\ Pro:h11
endif

if has("gui_macvim")
    " set macvim specific stuff
    " max horizontal height of window
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

" switch syntax highlighting on when terminal has colors
" also switch on highlighting the last used search pattern
" and set proper typeface
if &t_Co > 2 || has('gui_running')
    syntax on
    set hlsearch
endif

" autocommands!
autocmd FileType make set noexpandtab

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" jump to last cursor position when opening a file
" dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" tagbar settings
nnoremap <silent> <leader>b :TagbarToggle<CR>

" :make
nnoremap <silent> <leader>m :w<CR>:make<CR>:cw<CR>

" text bubbling - using Tim Pope's unimpaired plugin
nmap <C-h> <<
nmap <C-j> ]e
nmap <C-k> [e
nmap <C-l> >>
vmap <C-h> <<CR>gv
vmap <C-j> ]egv
vmap <C-k> [egv
vmap <C-l> ><CR>gv

" escape insert mode instantly
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" remove trailing whitespace on buffer write
autocmd BufWritePre * :%s/\s\+$//e

" diff unsaved changes to file
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" rebind join since we're using c-j for navigation
vmap <C-S-j> :join<CR>

" Ctags ------------------------------------------------------------------------

set tags=./.tags;/

" go to definition
nnoremap <C-g> <C-]>
"nnoremap <C-v><C-g> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <C-v><C-g> :sp <cr>:exec("tag ".expand("<cword>"))<cr>

" CtrlP ------------------------------------------------------------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
nnoremap <silent> <leader>t :CtrlPTag<cr>
nnoremap <silent> <leader>r :CtrlPMRU<cr>

" Gundo ------------------------------------------------------------------------

nnoremap <silent> <leader>u :GundoToggle<cr>

" Golang -----------------------------------------------------------------------

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" overwrite go-to-tag with godef in go files
au Filetype go nnoremap <C-g> :GoDef<cr>

" Ruby ------------------------------------------------------------------------

autocmd Filetype ruby set shiftwidth=2
autocmd Filetype ruby set tabstop=2
autocmd Filetype ruby set softtabstop=2

" Crontab ----------------------------------------------------------------------

autocmd filetype crontab setlocal nobackup nowritebackup

" XML prettifier ---------------------------------------------------------------

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" Set PWD to current file -----------------------------------------------------

function! DoUpdatePWDToCurrentFile()
    cd %:p:h
endfunction
command! UpdatePWDToCurrentFile call DoUpdatePWDToCurrentFile()

" Color modifications ---------------------------------------------------------

"highlight ColorColumn ctermbg=236 guibg=#3f3f3f
"highlight VertSplit ctermbg=236 ctermfg=236
""highlight NonText ctermfg=bg
"highlight CursorLineNR ctermbg=235
"highlight SignColumn ctermbg=235 ctermfg=235
"highlight SyntasticWarningSign ctermbg=235
"highlight SyntasticErrorSign ctermbg=235
"
"highlight
