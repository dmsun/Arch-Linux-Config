call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-git'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neomake/neomake'
Plug 'davidhalter/jedi-vim'
Plug 'python-mode/python-mode', {'branch': 'develop' }
call plug#end()

"When writing a buffer (no delay)."
call neomake#configure#automake('w')
let g:pymode_python = 'python3'
autocmd vimenter * NERDTree
