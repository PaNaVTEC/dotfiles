syntax enable
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

" Line numbers
set number

" NERDTree
" autocmd vimenter * NERDTree " Init NERDTree when starts
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" airline
let g:airline_powerline_fonts = 1
