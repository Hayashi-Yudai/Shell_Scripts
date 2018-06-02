"dein Scripts------------------------
if &compatible
	set nocompatible
endif

" Required:
set runtimepath+=/home/yudai/.cache/dein/repos/github.com/Shougo/dein.vim

"Required:
if dein#load_state('/home/yudai/.cache/dein')
	call dein#begin('/home/yudai/.cache/dein')

    "Let dein manege dein
	"Required:
	call dein#add('Shougo/dein.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('simeji/winresizer')
    call dein#add('thinca/vim-quickrun')
    call dein#add('vim-airline/vim-airline')
    if has('lua')
        call dein#add('Shougo/neocomplete.vim')
        call dein#add('Shougo/neosnippet')
        call dein#add('Shougo/neosnippet-snippets')
        call dein#add('davidhalter/jedi-vim')
        call dein#add('lervag/vimtex')
    endif

	"Add or remove your plugins here:
	"You can specify revision/branch/tag.

	"Required:
	call dein#end()
    call dein#save_state()
endif


"Required:
filetype plugin indent on
syntax enable

"If you want to isntall not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

"End dein Scripts-----------------------------------
"

"setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set backspace=indent,eol,start

"Visual
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set wildmode=list:longest
set tabstop=4

"Tab
set expandtab
set tabstop=4
set shiftwidth=4

"Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap j gj
nnoremap k gk

colorscheme janah

"キーマップ
nnoremap <silent><C-n> :NERDTreeToggle<CR>
nnoremap <expr><BS> neocomplete#smart_close_popup().
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

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

let g:quickrun_config={'python':{'command':'python3'},
            \'tex':{'command':'latexmk','outputter':'error','outputter/error/error':'quickfix',
            \'cmdopt':'-pdfdvi','exec':'%c %o %s'}}
let g:vimtex_compiler_latexmk={'callback':0}
