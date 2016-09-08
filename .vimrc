syntax enable
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
