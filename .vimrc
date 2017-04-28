call plug#begin('~/.vim/plugged')

"Core
Plug 'ctrlpvim/ctrlp.vim'
Plug 'justinmk/vim-dirvish'


"Bling
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

"Languages
Plug 'mhinz/vim-sayonara'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'sheerun/vim-polyglot'


Plug 'Valloric/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

set backspace=indent,eol,start

"clipboard
set clipboard=unnamed

"make menu more usable
set wildmenu
set wildmode=longest:full,full

"ignore case
set ignorecase
set smartcase

"automatically reload files
set autoread

set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h18
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

" undo file that lets you re-undo after closing the file
set undofile
set undodir=~/.vim/undodir

set autoindent

let mapleader=" "

nnoremap Q <Nop>
nnoremap q: :q<CR>
nnoremap QQ :Sayonara<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>Q :nohlsearch<CR>
nnoremap <leader> v
nnoremap <leader><leader> V
nnoremap <leader><leader><leader> <C-v>

set t_Co=256
set background=dark
colorscheme gruvbox
" set background=light
" colorscheme PaperColor

" run macros with Q
nnoremap Q @q


"Buffer bindings
nnoremap <leader>b :ls<cr>:b<space>


"Airline
""""""""

let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#tagbar#enabled = 1


"let g:airline#extensions#tabline#buffer_nr_show = 1
"allow buffers to be indexed
let g:airline#extensions#tabline#buffer_idx_mode = 1
"have buffer names be unique
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9


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
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>f :CtrlPMRU<CR>


"Haskell
""""""""
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 expandtab

"NERDTree
"""""""""
nmap <Leader>o :NERDTreeToggle<CR>

"RustyTags
"""""""""
setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"

"Racer
"""""

set hidden
let g:racer_cmd = "/Users/bollu/.cargo/bin/racer"

"Easytags
""""""""

let g:easytags_async = 1

"YouCompleteMe
""""""""""""""
let g:ycm_global_ycm_extra_conf='/Users/bollu/dotfiles/.ycm_extra_conf.py'

"Disable arrow Keys
"""""""""""""""""""

" Disable Arrow keys in Escape mode
"nmap <up> <nop>
"nmap <down> <nop>
"nmap <left> <nop>
"nmap <right> <nop>


"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>
"set autochdir
