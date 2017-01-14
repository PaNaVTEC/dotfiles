syntax enable
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

" Search 
Plug 'mileszs/ack.vim'

" Syntax
Plug 'plasticboy/vim-markdown'
" Plug 'elzr/vim-json'

" JS
Plug 'pangloss/vim-javascript'
	\| Plug 'mxw/vim-jsx' "JSX - For react
Plug 'heavenshell/vim-jsdoc'
Plug 'moll/vim-node'

" CSS
Plug 'JulesWang/css.vim'
        \| Plug 'hail2u/vim-css3-syntax'
	\| Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }

Plug 'ap/vim-css-color'

" Omnicompletion, this is beta repo, where stables are already in VIMRUNTIME
Plug 'othree/csscomplete.vim'

" Scala
Plug 'derekwyatt/vim-scala'
Plug 'ensime/ensime-vim'
" Plug 'ktvoelker/sbt-vim'
" Plug 'dscleaver/sbt-quickfix'

" General programming
" Plug 'scrooloose/syntastic'
Plug 'kien/rainbow_parentheses.vim'

"Ctrl p 
Plug 'ctrlp.vim'

call plug#end()

" Configures Ack.vim to use ag the silver searcher
if executable('ag')
	let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Line numbers
set number
set numberwidth=5

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
