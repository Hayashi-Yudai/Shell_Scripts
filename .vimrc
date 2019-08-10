"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/yudai/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
let s:dein_dir = '/home/yudai/.cache/dein'
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

"End dein Scripts-------------------------

"setting
set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set backspace=indent,eol,start
set vb t_vb=

"Visual
set number
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
colorscheme atom-dark-256
set t_Co=256

"キーマップ
"nnoremap O :<C-u>call append(expand('.'),'')<Cr>j
nnoremap <C-i> <C-a>

"airlineの設定
set laststatus=2
let g:airline#extensions#branch#enable=1
let g:airline#extensions#tableline#enable=1
let g:airline#extensions#wordcount#enable=0
let g:airline#extensions#default#layout=[['a','b','c'],['x','y','z']]
let g:airline_section_c='%t'
let g:airline_section_x='%{&filetype}'
let g:airline_section_z='%31:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
let g:airline#extensions#ale#error_symbol=' '
let g:airline#extensions#ale#warnign_symbol=' '
let g:airline#extensions#default#section_truncate_width={}
let g:airline#extensions#whitespace#enabled=1

let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#min_keyword_length=3
let g:neocomplete#enable_auto_delimeter=1
let g:neocomplete#auto_completion_start_length=1

let g:jedi#rename_command = "<C-R>"

imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
let g:neosnippet#snippets_directory='/home/yudai/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/snippets,~/.vim/snippets'

let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_rust_cargo_use_check = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_error = "✗"
let g:ale_sign_warning = "⚠"
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'rust': ['cargo'],
  \}
let g:ale_fixers = {
  \ 'python': ['black'],
  \}
let g:ale_fix_on_save = 1

let g:quickrun_config={'cpp/g++' : {'cmdopt':'-std=c++11'},
            \'python':{'command':'python'},
            \'tex':{'command':'latexmk','outputter':'error','outputter/error/error':'quickfix',
            \'cmdopt':'-pdfdvi','exec':'%c %o %s'}}
let g:vimtex_compiler_latexmk={'callback':0}

let g:acp_enableAtStartup=0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
" " Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
     \ 'default' : ''
     \ }

set list listchars=tab:\!\ 
"
 " Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 "<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-e>  neocomplcache#cancel_popup()
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

map <C-n> :NERDTreeToggle<CR>
