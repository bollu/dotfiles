call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'markonm/traces.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'jremmen/vim-ripgrep'
call plug#end()

colorscheme desertEx

set ignorecase
set smartcase

let g:asyncrun_open = 6


noremap <silent><f5> :AsyncTask file-run<cr>
noremap <silent><f9> :AsyncTask file-build<cr>
