call plug#begin('~/.vim/plugged')

"Core
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-startify'
Plug 'Rip-Rip/clang_complete'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cloudhead/neovim-fuzzy'
Plug 'vim-scripts/pyte'
Plug 'endel/vim-github-colorscheme'
Plug 'mhinz/vim-sayonara'

"Bling
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

"Languages
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'jceb/vim-orgmode'

" Terminal
Plug 'vimlab/split-term.vim'


call plug#end()


set nu
autocmd BufEnter * silent! lcd %:p:h "set the working directory sanely
inoremap jk <Esc>

set termguicolors

set clipboard+=unnamedplus
set clipboard=unnamedplus

"allow vim to auto-reload files
set autoread

set hlsearch
set incsearch
" 'smart case' for searching
set ignorecase

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
" set colorcolumn=80

" undo file that lets you re-undo after closing the file
set undofile
set undodir=~/.vim/undodir

"wildmenu?
set wildmenu
set wildmode=longest:full,full


let mapleader=" "
nnoremap q: :q<CR>
nnoremap QQ  :Sayonara<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader><leader> V
nnoremap <leader>1 :bp<CR>
nnoremap <leader>2 :bn<CR>

set background=light
colorscheme github
let g:airline_theme='wombat'

"set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h20

"Buffers"
"""""""""

nnoremap <leader>j :bprev<CR>
nnoremap <leader>k :bnext<CR>

"Airline
""""""""

let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1




"NERDTree
"""""""""
" nmap <Leader>o :NERDTreeToggle<CR>


"Ag
"""
" let g:ag_highlight=1


if has("nvim")
    " Make escape work in the Neovim terminal.
    tnoremap <Esc> <C-\><C-n>
    tmap jk <Esc>
    autocmd BufEnter term://* startinsert

    set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    set inccommand=nosplit
endif

"Clang complete
""""""""""""""
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

""Deoplete
"""""""""
"let g:deoplete#sources#clang#libclang_path='/usr/local/lib/libclang.dylib'
"let g:deoplete#sources#clang#clang_header='/usr/local/lib/clang/5.0.0/include'
""let g:deoplete#sources#clang#clang_header='/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include'
"let g:deoplete#enable_at_startup = 1
"call deoplete#enable()

"Disable arrow keys
"""""""""""""""""""
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>


imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"Fuzzy
""""""
nnoremap <C-p> :FuzzyOpen<CR>
set colorcolumn=80

" Give message when file is changed outside of vim/neovim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
au FocusGained * :checktime

" Trim trailing whitespace
" """"""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Using file extension
autocmd BufWritePre *.ll,*.h,*.c*,*.hs :call <SID>StripTrailingWhitespaces()

