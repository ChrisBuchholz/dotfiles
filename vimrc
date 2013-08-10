filetype off
let g:pathogen_disabled = []
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
set nocompatible

" credentials
let g:name = 'Christoffer Buchholz'
let g:email = 'christoffer.buchholz@gmail.com'

" preferences
syntax sync fromstart

let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 24

let mapleader = ","
let maplocalleader = "\\"

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

set ts=4 sw=4 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
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
set lazyredraw
set encoding=utf8
set fileencoding=utf8
set fileformat=unix
set backspace=indent,eol,start
set history=1000
set colorcolumn=81
highlight ColorColumn ctermbg=236 guibg=#3f3f3f
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

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

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

" explorer settings
nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>b :TagbarToggle<CR>

" :make
nnoremap <silent> <leader>m :w<CR>:make<CR>:cw<CR>

" text bubbling - using Tim Pope's unimpaired plugin
nmap <S-h> <<
nmap <S-j> ]e
nmap <S-k> [e
nmap <S-l> >>
vmap <S-h> <<CR>gv
vmap <S-j> ]egv
vmap <S-k> [egv
vmap <S-l> ><CR>gv

" clear search highlight
nnoremap <leader>/ :noh<cr><esc>

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

" Ctags ------------------------------------------------------------------------

set tags=./.tags;/

" go to definition
nnoremap <C-g> <C-]>
"nnoremap <C-v><C-g> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <C-v><C-g> :sp <cr>:exec("tag ".expand("<cword>"))<cr>

" CamelCaseMotion --------------------------------------------------------------

" replace w, b and e motions with camelcasemotions' commands
" this doesnt remove their normal behaviour - only add notion about
" camelcased and underscored naming convertions
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" CtrlP ------------------------------------------------------------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
nnoremap <silent> <leader>t :CtrlPTag<cr>

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

autocmd FileType go autocmd BufWritePre <buffer> :silent Fmt

" Tabularize -------------------------------------------------------------------

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Haskell ----------------------------------------------------------------------

let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s -a Google-Chrome %s"

" Crontab ----------------------------------------------------------------------

autocmd filetype crontab setlocal nobackup nowritebackup

" Airline ----------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

" XML Prettifier

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

" Symbols ---------------------------------------------------------------------

" superscripts
imap <buffer> ^0 ⁰
imap <buffer> ^1 ¹
imap <buffer> ^2 ²
imap <buffer> ^3 ³
imap <buffer> ^4 ⁴
imap <buffer> ^5 ⁵
imap <buffer> ^6 ⁶
imap <buffer> ^7 ⁷
imap <buffer> ^8 ⁸
imap <buffer> ^9 ⁹
imap <buffer> ^+ ⁺
imap <buffer> ^- ⁻
imap <buffer> ^= ⁼
imap <buffer> ^( ⁽
imap <buffer> ^) ⁾
imap <buffer> ^n ⁿ

" subscripts
imap <buffer> \_0 ₀
imap <buffer> \_1 ₁
imap <buffer> \_2 ₂
imap <buffer> \_3 ₃
imap <buffer> \_4 ₄
imap <buffer> \_5 ₅
imap <buffer> \_6 ₆
imap <buffer> \_7 ₇
imap <buffer> \_8 ₈
imap <buffer> \_9 ₉
imap <buffer> \_+ ₊
imap <buffer> \_- ₋
imap <buffer> \_= ₌
imap <buffer> \_( ₍

" arrows
imap <buffer> \-> →
imap <buffer> \<-- ←
imap <buffer> \<--> ↔
imap <buffer> \==> ⇒
imap <buffer> \<== ⇐
imap <buffer> \<==> ⇔

" symbols from mathematics and logic, LaTeX style
imap <buffer> \forall ∀
imap <buffer> \exists ∃
imap <buffer> \in ∈
imap <buffer> \ni ∋
imap <buffer> \empty ∅
imap <buffer> \prod ∏
imap <buffer> \sum ∑
imap <buffer> \le ≤
imap <buffer> \ge ≥
imap <buffer> \pm ±
imap <buffer> \subset ⊂
imap <buffer> \subseteq ⊆
imap <buffer> \supset ⊃
imap <buffer> \supseteq ⊇
imap <buffer> \setminus ∖
imap <buffer> \cap ∩
imap <buffer> \cup ∪
imap <buffer> \int ∫
imap <buffer> \therefore ∴
imap <buffer> \qed ∎
imap <buffer> \1 𝟙
imap <buffer> \N ℕ
imap <buffer> \Z ℤ
imap <buffer> \C ℂ
imap <buffer> \Q ℚ
imap <buffer> \R ℝ
imap <buffer> \E 𝔼
imap <buffer> \F 𝔽
imap <buffer> \to →
imap <buffer> \mapsto ↦
imap <buffer> \infty ∞
imap <buffer> \cong ≅
imap <buffer> \:= ≔
imap <buffer> \=: ≕
imap <buffer> \ne ≠
imap <buffer> \approx ≈
imap <buffer> \perp ⊥
imap <buffer> \not ̷
imap <buffer> \ldots …
imap <buffer> \cdots ⋯
imap <buffer> \cdot ⋅
imap <buffer> \circ ◦
imap <buffer> \times ×
imap <buffer> \oplus ⊕
imap <buffer> \langle ⟨
imap <buffer> \rangle ⟩

" greek alphabet...
imap <buffer> \alpha α
imap <buffer> \beta β
imap <buffer> \gamma γ
imap <buffer> \delta δ
imap <buffer> \epsilon ε
imap <buffer> \zeta ζ
imap <buffer> \nu η
imap <buffer> \theta θ
imap <buffer> \iota ι
imap <buffer> \kappa κ
imap <buffer> \lambda λ
imap <buffer> \mu μ
imap <buffer> \nu ν
imap <buffer> \xi ξ
imap <buffer> \omicron ο
imap <buffer> \pi π
imap <buffer> \rho ρ
imap <buffer> \stigma ς
imap <buffer> \sigma σ
imap <buffer> \tau τ
imap <buffer> \upsilon υ
imap <buffer> \phi ϕ
imap <buffer> \varphi φ
imap <buffer> \chi χ
imap <buffer> \psi ψ
imap <buffer> \omega ω

imap <buffer> \Alpha Α
imap <buffer> \Beta Β
imap <buffer> \Gamma Γ
imap <buffer> \Delta Δ
imap <buffer> \Epsilon Ε
imap <buffer> \Zeta Ζ
imap <buffer> \Nu Η
imap <buffer> \Theta Θ
imap <buffer> \Iota Ι
imap <buffer> \Kappa Κ
imap <buffer> \Lambda Λ
imap <buffer> \Mu Μ
imap <buffer> \Nu Ν
imap <buffer> \Xi Ξ
imap <buffer> \Omicron Ο
imap <buffer> \Pi Π
imap <buffer> \Rho Ρ
imap <buffer> \Sigma Σ
imap <buffer> \Tau Τ
imap <buffer> \Upsilon Υ
imap <buffer> \Phi Φ
imap <buffer> \Chi Χ
imap <buffer> \Psi Ψ
imap <buffer> \Omega Ω
