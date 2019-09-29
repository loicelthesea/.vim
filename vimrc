" ############################
" Vimrc inspirations:
" https://dougblack.io/words/a-good-vimrc.html
" ############################

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" #################
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

" Set to autoread when a file is changed from the outside
set autoread
au FocusGained,BufEnter * :silent! !

" Set to refuse unsaved hidden buffer
set nohidden

" let mapleader = ","
" let g:mapleader = ","
inoremap jk <esc>

" #################
" #### Plugins ####

" Pathogen ( autoload plugin inside ./bundle/{} )
execute pathogen#infect()

" Unite
" let g:unite_enable_start_insert=1
" let g:unite_source_history_yank_enable=1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])

" nnoremap <leader>p :Unite file_rec/async<cr> 
" nnoremap <leader>/ :Unite grep:.<cr>
" nnoremap <leader>y :Unite history/yank<cr>
" nnoremap <leader>b :Unite buffer<cr>

" Emmet-vim
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_mode='a'    "enable all function in all mode.

" Vim JSX 
let g:jsx_ext_required = 0 " Works with js files

" Prettier
let g:prettier#autoformat = 0
augroup PRETTIER
  autocmd BufWritePre *.js,*.css,*.scss,*.less Prettier
augroup END

" Macro Matchit
" configure % to match more than just single characters
runtime macros/matchit.vim

" #################
" #### VIM GUI ####

set relativenumber
set number
set cursorline
set cmdheight=1
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

" Set folding
" set foldenable
" set foldlevelstart=3
" set foldnestmax=5
" set foldmethod=indent

" Sets minimum Window Width and Heigth to 0
set winminheight=0 winminwidth=0

" Statusline
  " always visible
set laststatus=2              
  " Buffer: + 80max filepath + Modified flag
set statusline=%02n:%.80f%m
  " switch to right
set statusline+=%=             
  " (cursor,line/total)
set statusline+=(%c-%l/%L)    
  " Filetype
set statusline+=%y            

" #################
" #### Search & Replace
set ignorecase
set smartcase
set hlsearch
set magic

map <silent> <leader><CR> :set hlsearch! hlsearch?<CR>

" #################
" ####  Syntax 
augroup syntaxing
  au BufEnter,BufNew *.php :set filetype=html
  au BufRead,BufNewFile *.hbs set filetype=html
augroup END

" #################
" ####  Commenting blocks of code.
augroup commenting
  autocmd FileType c,cpp,java,scala   let b:comment_leader = '// '
  autocmd FileType sh,ruby,python,php let b:comment_leader = '# '
  autocmd FileType conf,fstab         let b:comment_leader = '# '
  autocmd FileType tex                let b:comment_leader = '% '
  autocmd FileType mail               let b:comment_leader = '> '
  autocmd FileType vim                let b:comment_leader = '" '
  autocmd FileType sh,ruby,python,php setlocal commentstring=#\ %s
augroup END

" #################
" #### Completion

set completeopt=longest,menuone
augroup completion
  autocmd!
  autocmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css,less       setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript     setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python         setlocal omnifunc=python3complete#Complete
  autocmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
augroup END

" Remap Ctrl Space for auto completion
imap <C-Space> <C-x><C-o>


" #################
" #### Colors and Fonts ####

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

if has("gui_running")
  set lines=999 columns=999
  set guitablabel=%M\ %t
  set guioptions-=m " No menu
  set guioptions-=T " No Toolbar
  set guioptions-=e " 
  set guioptions-=r " No Right scroll bar
  set guioptions-=L " No Left scroll bar
  
  colorscheme one
  set background=dark

  " Fonts
  if has("gui_gtk2")
    set guifont=Fira\ Mono\ 11
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif

else
  set t_Co=256
  set background=dark
  colorscheme onedark
endif


" #################
" #### Files, backups and undo
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use backup, swap, undo files but set them in a different folder
set backup
set backupcopy=yes
set writebackup
set swapfile
set backupdir=.backup/,~/.vim/.backup//,~/.tmp//,/tmp//
set directory=.swap/,~/.vim/.swap//,~/.tmp//,/tmp//
set undodir=.undo,/~/.vim/.undo//,~/.tmp//,/tmp//

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Ccd = Change directory to current file
if !exists(":Ccd") 
  command Ccd cd %:p:h
endif

" Lcd = Change directory of current window to current file
if !exists(":Lcd") 
  command Lcd lcd %:p:h
endif

" #################
" #### Text, tab and indent related

" Use spaces instead of tabs & Be smart when using tabs ;)
set expandtab smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Remove auto inserting line when writing comments
augroup COMMENTS
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Linebreak
set wrap
set linebreak
set showbreak=++\ 

" Indentation
set autoindent

" #################
" #### Moving around, tabs, windows and buffers

" Open new windows below or on the right
set splitbelow splitright

" Disable autoresizing 
set noequalalways

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Move to beginning/end of line
nnoremap B ^
nnoremap E $

" Smart way to move between windows
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>\|
map <C-l> <C-W>l<C-W>\|

" Easy access to :tags with <F9> (use <C-MAJ-$> on azerty)
nmap <F9> <C-]>
map! <F9> <C-]>

