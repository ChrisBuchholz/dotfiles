" use vim settings rather than vi settings
" this must be first, because it changes other settings as a side-effect
set nocompatible

" filetype off fix for pathogen
filetype off

" call pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" credentials
let g:name = 'Christoffer Buchholz'
let g:email = 'christoffer.buchholz@gmail.com'

" allow backspacing over everything in insert-mode
set backspace=indent,eol,start

" keep 1000 lines of command-history
set history=1000

" show the cursor position at all times
set ruler

" ignore case
set noic

" folding settings
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " this is just what i use

" display incomplete commands
set showcmd

" do incremental search
set incsearch

" in most terminal emulators, the mouse works fine, so enable it!
if has('mouse')
    set mouse=a
endif

if has("gui_running")
    " disable toolbar, menubar, scrollbars
    set guioptions=aiA " Disable toolbar, menu bar, scroll bars
    " hide mouse when typing
    set mousehide
    " font
    set guifont=Meslo\ LG\ M\ DZ\ 9
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

" preferences
set bg=dark
syntax sync fromstart
let g:molokai_original=1
colorscheme molokai
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)
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

"set viminfo='1000,f1,:1000,/1000
set lazyredraw

" enable filetype plugin and indentation
filetype plugin indent on

" autocommands!
autocmd FileType make set noexpandtab

" encoding
set encoding=utf8
set fileencoding=utf8
set fileformat=unix

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" :make
nmap <F4> :w<CR>:make<CR>:cw<CR>

" nerdtree
map <F2> :NERDTreeToggle<CR>

" pydiction
let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'

" text bubbling - using Tim Pope's unimpaired plugin
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

" Viewport Controls
" ie moving between split panes
map <silent>,h <C-w>h
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l

" diff unsaved changes to file
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" strip trailing whitespaces
function! Preserve(command)
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>


" various UTF-8 mappings

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
