" ##############################################
" Vimrc inspirations: https://dougblack.io/words/a-good-vimrc.html
" ##############################################

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" ##############################################
" #### General
" ##############################################

" Enable filetype plugins
filetype plugin on
filetype indent on

" No annoying sound on errors
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Sets how many lines of history VIM has to remember
set history=10000

" Set to autoread when a file is changed from the outside
set autoread
au FocusGained,BufEnter * :silent! !

" Set to allow unsaved hidden buffer
set hidden

" ##############################################
" #### Plugins
" ##############################################

" Macro Matchit (native plugin)
" configure % to match more than just single characters
runtime macros/matchit.vim

" FZF
augroup FZF
  set rtp+=~/.fzf
augroup END

" Ack.vim + ag
" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
" endif

" Emmet-vim
let g:user_emmet_leader_key='<leader>e'
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Vim JSX
let g:jsx_ext_required = 0 " Works with js files

" Typescript
let g:typescript_indent_disable = 1

" Prettier // config not needed with ALE
" augroup PRETTIER
"   let g:prettier#autoformat_require_pragma = 0
"   let g:prettier#autoformat_config_present = 1
"   let g:prettier#autoformat_config_files = ['.prettierrc']
"   let g:prettier#exec_cmd_path = "~/.nvm/versions/node/v10.18.1/bin/prettier"
"
"   autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
"   autocmd FileType php let b:prettier_ft_default_args = { 'parser': 'php' }
" augroup END

" ALE
augroup ALE
  let g:ale_open_list = 1
  let g:ale_keep_list_window_open = 0
  let g:ale_list_vertical = 0
  let g:ale_set_quickfix = 0
  let g:ale_set_loclist = 1
  let g:ale_sign_column_always = 1

  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_enter = 0

  let g:ale_linters = {
    \   'javascript': ['eslint', 'tsserver'],
    \   'typescript': ['eslint', 'tsserver'],
    \   'vue': ['eslint']
    \}

  let g:ale_fix_on_save = 1
  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'javascript': ['remove_trailing_lines', 'trim_whitespace', 'prettier', 'eslint'],
        \ 'typescript': ['remove_trailing_lines', 'trim_whitespace', 'prettier', 'eslint'],
        \ 'vue': ['remove_trailing_lines', 'trim_whitespace', 'prettier', 'eslint'],
        \ 'scss': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
        \ 'html': ['prettier'],
        \ 'md': ['prettier', 'eslint']
        \}

  let g:ale_completion_enabled = 1
  let g:ale_completion_tsserver_autoimport = 0
augroup END

" ##############################################
" #### VIM GUI ####
" ##############################################

set number
set norelativenumber
set scrolloff=10
set nocursorline
set cmdheight=1
set wildchar=<Tab> wildmenu wildmode=full

" Configure visual vertical line at 100
set colorcolumn=80
highlight ColorColumn ctermbg=black guibg=gray18

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

" Ignore white space for diff
set diffopt+=iwhite

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Show matching brackets when text indicator is over them
set showmatch
set matchtime=1

" Sets minimum Window Width and Heigth to 0
set winminwidth=20 winminheight=0

" Statusline
"- always visible
set laststatus=2
set statusline=
"- Window Number
set statusline+=%{winnr()}:
"- Buffer: + 80max filepath + Modified flag + Readonly
set statusline+=%03n:%{expand('%:~:.120f')}%m%r
"- switch to right
set statusline+=%=
"- (cursor,line/total)
set statusline+=%03l-%c/%L(%P)
"- Filetype
set statusline+=%y

" ##############################################
" #### Search & Replace
" ##############################################

set ignorecase
set smartcase
set hlsearch
set magic

" ##############################################
" ####  Syntax
" ##############################################

augroup syntaxing
  " Enable syntax highlighting
  syntax on

  "au BufEnter,BufNew *.php :set filetype=php
augroup END

" ##############################################
" ####  Commenting blocks of code.
" ##############################################

augroup commenting
  autocmd FileType c,cpp,java,scala   let b:comment_leader = '// '
  autocmd FileType sh,ruby,python,php let b:comment_leader = '# '
  autocmd FileType conf,fstab         let b:comment_leader = '# '
  autocmd FileType tex                let b:comment_leader = '% '
  autocmd FileType mail               let b:comment_leader = '> '
  autocmd FileType vim                let b:comment_leader = '" '
augroup END

" ##############################################
" #### Completion
" ##############################################

augroup completion
  " set omnifunc=syntaxcomplete#Complete
  " set omnifunc=ale#completion#OmniFunc
  set completeopt=longest,menuone,preview
  " autocmd!
  " autocmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
  " autocmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType css,less       setlocal omnifunc=csscomplete#CompleteCSS
  " autocmd FileType javascript     setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python         setlocal omnifunc=python3complete#Complete
   " autocmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
   " inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<TAB>"
   " inoremap <expr><C-j>  pumvisible() ? "\<C-n>" : "\<TAB>"
augroup END

" ##############################################
" #### Colors and Fonts
" ##############################################

if has("gui_running")
  set lines=999 columns=999
  set guitablabel=%M\ %t
  set guioptions-=m " No menu
  set guioptions-=T " No Toolbar
  set guioptions-=e "
  set guioptions-=r " No Right scroll bar
  set guioptions-=L " No Left scroll bar

  set background=dark
  colorscheme one2

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
  set background=light
  colorscheme one
endif


" ##############################################
" #### Files, backups and undo
" ##############################################

set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Use backup, swap, undo files but set them in a different folder
set backup
set backupcopy=yes
set writebackup
set swapfile
set backupdir=.backup/,~/.vim/.backup//,~/tmp//,/tmp//
set directory=.swap/,~/.vim/.swap//,~/tmp//,/tmp//
set undodir=.undo,/~/.vim/.undo//,~/tmp//,/tmp//

" Ccd = Change directory to current file
if !exists(":Ccd")
  command Ccd cd %:p:h
endif

" Lcd = Change directory of current window to current file
if !exists(":Lcd")
  command Lcd lcd %:p:h
endif

" ##############################################
" #### Text, tab and indent related
" ##############################################

" Use spaces instead of tabs & Be smart when using tabs ;)
set expandtab smarttab

" 1 tab == 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Remove auto inserting line when writing comments
augroup COMMENTS
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Linebreak
set wrap
set linebreak
set showbreak=~~\

" Indentation
set autoindent

" ##############################################
" #### Moving around, tabs, windows and buffers
" ##############################################

" Open new windows below or on the right
set splitbelow splitright

" Disable autoresizing
set noequalalways

" ##############################################
" #### SHORTCUTS
" ##############################################

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Map Space to command line
noremap <space> :
vnoremap <space> :

nnoremap gj G
nnoremap gk gg
nnoremap gh ^
nnoremap gl $

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" Move to beginning/end of line
" nnoremap B ^
" nnoremap E $

" Disable CTRL-Z
nnoremap <c-z> <nop>

" Unmap arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Stacks windows when navigate
noremap <C-j> <C-W>j<C-W>_
noremap <C-k> <C-W>k<C-W>_
noremap <C-h> <C-W>h<C-W>\|
noremap <C-l> <C-W>l<C-W>\|

" Fast maximise windows
noremap <leader>- <C-W>_

" Easy escape Insert Mode
inoremap jj <esc>
inoremap kk <esc>

" Mappings to access buffers
nnoremap <C-b> :buffers<CR>:b<Space>
nnoremap <C-b><C-b> :e#<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" Mappings for vimdiff
if &diff
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

" Remap Ctrl Space for auto completion
if !has("gui_running")
  if has("unix")
    inoremap <C-@> <C-x><C-o>
  elseif has("win32")
    inoremap <C-Space> <C-x><C-o>
  endif
else
    inoremap <C-Space> <C-x><C-o>
endif


" Easy copy paste on server
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>

" Easy save & quit
nnoremap <leader>w :<C-u>update!<cr>
nnoremap <leader>q :q<cr>

" Highlight/Hide current search
nnoremap <silent> <leader><CR> :set hlsearch! hlsearch?<CR>

" Quickfix & Location List
nnoremap <C-l><C-n> :lnext<CR>
nnoremap <C-l><C-p> :lprevious<CR>
nnoremap <C-c><C-n> :cnext<CR>
nnoremap <C-c><C-p> :cprevious<CR>

" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>H :History:<CR>

" ALE
nnoremap <leader>L :ALELint<CR>
nnoremap <leader>F :ALEFix<CR>
nnoremap <F10> :ALEHover<CR>
nnoremap <F11> :ALEFindReferences<CR>
nnoremap <F12> :ALEGoToDefinition<CR>

" ##############################################
" #### Tags generation
" ##############################################

silent! helptags ALL
