syntax enable
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

set number " Line numbers

autocmd vimenter * NERDTree " Init NERDTree when starts
map <C-n> :NERDTreeToggle<CR>
