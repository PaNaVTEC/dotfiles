syntax enable
set nocompatible
source ~/dotfiles/.vimrc.plugins

set encoding=utf8
" Colors
set tgc
set background=dark
colorscheme hybrid_material

let g:airline_theme = "hybrid"
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
set t_ut=

" Display a line at column 80
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif

" Configures Ack.vim to use ag the silver searcher
if executable('ag')
  let g:FerretExecutable='ag,rg'
  "let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Indentation
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

let mapleader = ","

" Test vim plugin configuration
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "asyncrun"
let g:test#runner_commands = ['Mocha']

" test-vim js configuration
"let g:test#javascript#mocha#file_pattern = '\vtests?/.*\.(js|jsx|coffee)$'
let g:test#javascript#mocha#file_pattern = '.*\.test\.js$'

let test#javascript#mocha#options = {
  \ 'nearest': '--compilers js:babel-core/register unitTest.config.js -c',
  \ 'file':    '--compilers js:babel-core/register unitTest.config.js -c',
  \ 'suite':   '--compilers js:babel-core/register unitTest.config.js -c',
\}

" AsyncRun
augroup vimrc
    " Open quickfix window when start running test
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    " Focus quickfix and color the output when stop
    autocmd User AsyncRunStop copen | AnsiEsc 
augroup END

" Line numbers
set number
"set relativenumber
set numberwidth=2
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

function! OnBufEnter()
  if (@% == "NERD_tree_1") | set nolist | else | set list | endif
  if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endfunction

" Show hidden chars
set listchars=eol:¬,tab:▸␣,nbsp:␣,trail:␣,extends:→,precedes:←
hi NonText ctermfg=8 guifg=Grey39
hi SpecialKey ctermfg=8 guifg=Grey39
autocmd bufenter * call OnBufEnter()

" Set highlight while searching
set hlsearch
set incsearch

"Show context around current cursor position
set scrolloff=8
set sidescrolloff=16

" don't syntax highlight long lines
set synmaxcol=512

" NERDTree
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let g:ctrlp_dont_split = 'NERD'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " This fixes a bug that prevents the bar not showing with nerdtree

" Scala config
autocmd BufWritePost *.scala silent :EnTypeCheck  "ensine type check after writing

" Toggle rainbow braces on
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs':['#2c89a9', '#7acab0', '#ffaa88', '#28a0e0' , '#CC5875', '#FFCCC8', '#FFC376'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

" Allow clipboard outside vim
set clipboard+=unnamed
vnoremap <C-c> "+y

" Replace all occourrences
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

au BufReadPost Jenkinsfile set syntax=groovy
au BufReadPost Jenkinsfile set filetype=groovy

" Clojure
filetype plugin indent on

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let s:eslint_path = system('PATH=$(npm bin):$PATH && (which eslint_d)')
let g:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
"let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'

"Gundo
map <C-g> :GundoToggle<CR>

" Backup and tmps in the same folder 
set backupdir=~/.backup
set directory=~/.tmp

" Multiple cursors keybindings
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" sudo shutup and write the file
cmap w!! w !sudo tee % >/dev/null

" persistent undo
set undofile
set undodir=~/.vim/undodir

" ctrlp ignore non relevant files
set wildignore+=*/node_modules/*,*/.git/*,*.so,*.swp,*.zip,*.exe,*.dll
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|node_modules)$'

" Cursor shape to vertical bar while in insert mode
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[0 q"

" Typo avoider
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

