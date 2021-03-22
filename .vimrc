call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Olical/conjure'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
call plug#end()


set clipboard+=unnamedplus
let mapleader = " "
nnoremap <Tab> :bn!<CR>
nnoremap <leader><Tab> :bp!<CR>
nnoremap <S-Tab> :bp!<CR>
set incsearch
set ignorecase
"set spell
colorscheme C64

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

"copen: open quickfix. Mnemonic: 'cope' with the error
