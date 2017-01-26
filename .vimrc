syntax enable
set nocompatible               " be iMproved

source ~/dotfiles/.vimrc.plugins

" Configures Ack.vim to use ag the silver searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
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
let test#strategy = "dispatch"

" Line numbers
set number
set relativenumber
set numberwidth=5

" Show hidden chars
if has('gui_running')
  set listchars=eol:¬,tab:▸␣,nbsp:␣,trail:␣,extends:→,precedes:←
else
  set listchars=eol:¬,tab:▸␣,nbsp:␣,trail:␣,extends:→,precedes:←
  "set listchars=eol:¬,tab:>-,nbsp:.,trail:.,extends:>,precedes:<
endif

set list
hi NonText ctermfg=8 guifg=Gray
hi SpecialKey ctermfg=8 guifg=Gray

" Set highlight while searching
set hlsearch
set incsearch

"Show context around current cursor position
set scrolloff=8
set sidescrolloff=16

set synmaxcol=512                     " don't syntax highlight long lines

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2 " This fixes a bug that prevents the bar not showing with nerdtree

" Scala config
autocmd BufWritePost *.scala silent :EnTypeCheck  "ensine type check after writing

" Toggle rainbow braces on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

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

"Gundo
map <C-g> :GundoToggle<CR>

