"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/yudai/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
let s:dein_dir = '~/.cache/dein'
let g:rc_dir = expand('~/.vim/rc/')
let s:toml = g:rc_dir . 'dein.toml'
let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

    call dein#load_toml(s:toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})

	call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

call dein#recache_runtimepath()

"End dein Scripts-------------------------

"setting
set fileformats=unix,dos,mac
set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set encoding=utf8
set guifont=DroidSansMono\ Nerd\ Font\ 11
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set backspace=indent,eol,start
set vb t_vb=
set clipboard=unnamedplus
set number

"Visual
set cursorline
set virtualedit=onemore
"set smartindent
set visualbell
set showmatch
set wildmode=list:longest

"Tab
set expandtab
set tabstop=2
set shiftwidth=2

"Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap j gj
nnoremap k gk

syntax on
colorscheme lucius
set background=dark
set t_Co=256

"キーマップ
nnoremap <C-i> <C-a>

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
