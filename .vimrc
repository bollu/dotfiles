call plug#begin('~/.vim/plugged')


"Core
Plug 'terryma/vim-expand-region'
"Plug 'Valloric/YouCompleteMe'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'mhinz/vim-sayonara'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mhinz/vim-startify'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-surround'
Plug 'tweekmonster/braceless.vim'
Plug 'xolox/vim-easytags'
Plug 'easymotion/vim-easymotion'

"
"Bling
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'jscappini/material.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-vinegar'
Plug 'AlessandroYorba/Sierra'

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Languages
Plug 'tpope/vim-fireplace' 
Plug 'rust-lang/rust.vim'
Plug 'https://github.com/Harenome/vim-mipssyntax'
Plug 'lervag/vimtex'
Plug 'lambdatoast/elm.vim'
Plug 'elmanuelito/vim-matlab-behave'
Plug '4Evergreen4/vim-hardy'
Plug 'bitc/vim-hdevtools'

call plug#end()

set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h16
set nu
autocmd BufEnter * silent! lcd %:p:h "set the working directory sanely
inoremap jk <Esc>

set hlsearch
set incsearch
" size of a hard tabstop
set tabstop=4

" size of an 'indent'
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4
" make 'tab' insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab"

"colored column at 80
set colorcolumn=80


let mapleader=" "
nnoremap q: :q<CR>
nnoremap QQ :Sayonara<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>/ :nohlsearch<CR>

set background=dark
colorscheme gruvbox

"set background=light
"colorscheme solarized
" let g:sierra_Midnight = 1
" colorscheme sierra
" colorscheme wombat


"Incsearch
""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Airline
""""""""

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#tagbar#enabled = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
"Expand Region
""""""""""""""
nnoremap <S-Up> <Plug>(expand_region_expand)
nnoremap <S-Down> <Plug>(expand_region_shrink)

" Syntastic
" """"""""


"Braceless
"""""""""
autocmd FileType python BracelessEnable +indent +highlight

"Neovim Config
"""""""""""""

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap  <C-\><C-n>
endif

"CtrlP
""""""
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>


"Haskell
""""""""

autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 expandtab

"NERDTree
"""""""""

nmap <Leader>o :NERDTreeToggle<CR>
