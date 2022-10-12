"setting
set fileformats=unix,dos,mac
set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set encoding=utf8
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
colorscheme codedark
set background=dark
set t_Co=256

"キーマップ
nnoremap <C-i> <C-a>

let g:jedi#rename_command = "<C-R>"

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

vnoremap < <gv
vnoremap > >gv
