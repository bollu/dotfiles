call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Olical/conjure'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'rhysd/vim-clang-format'
Plug 'rhysd/vim-clang-format'
Plug 'cormacrelf/vim-colors-github'
Plug 'sheerun/vim-polyglot'
Plug 'vlime/vlime'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'sjl/badwolf'
Plug 'sakibmoon/vim-colors-notepad-plus-plus'
Plug 'letorbi/vim-colors-modern-borland'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
call plug#end()



set clipboard+=unnamedplus
let mapleader = " "
nnoremap <Tab> :bn!<CR>
nnoremap <leader><Tab> :bp!<CR>
nnoremap <S-Tab> :bp!<CR>
set incsearch
set ignorecase
set smartcase
"set spell
set autochdir
let g:BorlandStyle = "classic"
set termguicolors
colorscheme borland
colorscheme gruvbox
colorscheme solarized8_high
set background=dark
"colorscheme C64
"colorscheme bruin
set tabstop=4
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"" Conjure

let g:coc_global_extensions = ['coc-conjure']
let maplocalleader = ","
let g:conjure#mapping#eval_current_form = "er"
let g:conjure#mapping#eval_root_form = "ee"
let g:conjure#mapping#def_word = "d"
let g:conjure#mapping#eval_visual = "E"
let g:conjure#mapping#eval_motion = "E"

nnoremap [q :cp!<CR>
nnoremap q] :cn!<CR>
nnoremap [b :bp!<CR>
nnoremap b] :bn!<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

nmap <silent> gd <Plug>(coc-definition)


au BufRead,BufNewFile *.mlir set syntax=c

" Find files using Telescope command-line sugar.
"dired
nnoremap <C-p> <cmd>Telescope git_files<CR>
nnoremap <C-f> <cmd>Telescope file_browser<CR>
nnoremap <C-s> <cmd>Telescope grep_string<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_workspace_symbols<cr>


source /home/bollu/dotfiles/digraph.vim

"copen: open quickfix. Mnemonic: 'cope' with the error
