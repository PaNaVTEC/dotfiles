call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wincent/ferret'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'marijnh/tern_for_vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Chiel92/vim-autoformat'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Repl suppoprt
Plug 'jpalardy/vim-slime'

" Snippets engine + snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Markdown
Plug 'plasticboy/vim-markdown'

"Git
Plug 'tpope/vim-fugitive'
    \| Plug 'airblade/vim-gitgutter'

" JS
Plug 'pangloss/vim-javascript'
      \| Plug 'mxw/vim-jsx'
      \| Plug 'heavenshell/vim-jsdoc'
      \| Plug 'jungomi/vim-mdnquery'
      \| Plug 'moll/vim-node', { 'for' : ['js'] }
" Hbs
Plug 'mustache/vim-mustache-handlebars'

Plug 'fatih/vim-go', { 'for' : ['go'] }

" CSS
Plug 'JulesWang/css.vim'
      \| Plug 'hail2u/vim-css3-syntax'
      \| Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'ap/vim-css-color'
      \| Plug 'othree/csscomplete.vim', { 'for' : 'css' }

" Scala
Plug 'derekwyatt/vim-scala'
    "\| Plug 'ensime/ensime-vim'
    "\| Plug 'ktvoelker/sbt-vim'
    "\| Plug 'zmre/vim-scala-async-integration'
    "\| Plug 'vim-syntastic/syntastic'
" Plug 'dscleaver/sbt-quickfix'

" Clojure
Plug 'venantius/vim-cljfmt'
  \| Plug 'guns/vim-clojure-static'
  \| Plug 'venantius/vim-eastwood'
  \| Plug 'tpope/vim-salve'
  \| Plug 'tpope/vim-fireplace', { 'for' : ['clojure'] }

" Haskell 
Plug 'eagletmt/neco-ghc'
  \| Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" General writing
Plug 'junegunn/goyo.vim'

" Linting
Plug 'w0rp/ale'

" General programming
Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'janko-m/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/Improved-AnsiEsc'

" Themes and colors
Plug 'vim-airline/vim-airline-themes'
    \| Plug 'arcticicestudio/nord-vim'
    \| Plug 'ryanoasis/vim-devicons'
    \| Plug 'chriskempson/base16-vim'
call plug#end()
