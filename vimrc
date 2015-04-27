" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" #### General ####

" Enable filetype plugins
filetype plugin on
filetype indent on

" No annoying sound on errors
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Sets how many lines of history VIM has to remember
set history=10000

" Enable syntax highlighting
syntax enable 

" Set to auto read when a file is changed from the outside
set autoread
set hidden

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"


" #### Plugins ####

" Pathogen
execute pathogen#infect()

" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>p :Unite file_rec/async<cr> 
nnoremap <leader>/ :Unite grep:.<cr>
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>b :Unite buffer<cr>


" #### VIM GUI ####

set cmdheight=1
set relativenumber
set wildchar=<Tab> wildmenu wildmode=full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Show matching brackets when text indicator is over them
set showmatch 
set matchtime=1

" Sets minimum Window Width and Heigth to 0
set winminheight=0 winminwidth=0

" Statusline
set laststatus=2              "always visible
" set statusline=%02n:%.80F     "buffer : 80maxch-filepath
" set statusline+=%=            "switch to right
" set statusline+=%y            "Filetype
" set statusline+=(%c,%l/%L)    "(cursor,line/total)

" #### Search & Replace
set ignorecase
set smartcase
set hlsearch
set magic

map <silent> <leader><CR> :set hlsearch! hlsearch?<CR>


" #### Completion

" Enable omni completion.
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css,less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Remap Ctrl Space for auto completion
imap <C-Space> <C-x><C-o>


" #### Colors and Fonts ####
set guifont=inconsolata\ 9 
set guitablabel=%M\ %t

set t_Co=256
set background=dark
if has("gui_running")
  set lines=999 columns=999
  set guioptions-=m " No menu
  set guioptions-=T " No Toolbar
  set guioptions-=e " 
  set guioptions-=r " No Right scroll bar
  set guioptions-=L " No Left scroll bar
  colorscheme molokai
else
  colorscheme molokai
endif


" #### Files, backups and undo ####
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use backup & swap but set them in a different folder
set backupdir=~/.vimtmp//,./.backup//,.,/tmp//
set directory=~/.vimtmp//,./.backup//,.,/tmp//

" Ccd = Change directory to current file
if !exists(":Ccd") 
  command Ccd cd %:p:h
endif

" #### Text, tab and indent related ####

" Use spaces instead of tabs & Be smart when using tabs ;)
set expandtab smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Remove auto inserting line when writing comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Linebreak
set wrap
set linebreak
set showbreak=++\ 

" Indentation
set autoindent smartindent 

" #### Moving around, tabs, windows and buffers ####

" Open new windows below or on the right
set splitbelow splitright

" Disable autoresizing 
set noequalalways

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>\|
map <C-l> <C-W>l<C-W>\|

