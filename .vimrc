syntax enable
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

" Syntax
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'

" Scala
Plug 'derekwyatt/vim-scala'
Plug 'ensime/ensime-vim'
" Plug 'ktvoelker/sbt-vim'
" Plug 'dscleaver/sbt-quickfix'

" General programming
Plug 'scrooloose/syntastic'
Plug 'kien/rainbow_parentheses.vim'

call plug#end()

" Line numbers
set number

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
