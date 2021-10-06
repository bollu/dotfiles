"https://github.com/nanotee/nvim-lua-guide
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'Julian/lean.nvim'
Plug 'nvim-lua/plenary.nvim' "coros
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'glepnir/lspsaga.nvim' "autocmplete via LSP
Plug 'kosayoda/nvim-lightbulb'  "show lightbulb when LSP action is available
Plug 'ms-jpq/coq_nvim' "automcoplete via LSP
Plug 'nvim-lua/completion-nvim'

" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} -- snippets
"
Plug 'stevearc/aerial.nvim' " minimap of file


"Debugger protocol
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'




"Lua dev
Plug 'bfredl/nvim-luadev' "REPL
Plug 'rafcamlet/nvim-luapad' "lua scratchpad
Plug 'tjdevries/nlua.nvim' "lua development env
Plug 'euclidianAce/BetterLua.vim'
" Plug 'floobits/floobits-neovim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'
"Plug 'Olical/conjure'
"Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
"Plug 'rhysd/vim-clang-format'
"Plug 'cormacrelf/vim-colors-github'
"Plug 'sheerun/vim-polyglot'
"Plug 'vlime/vlime'
Plug 'sjl/badwolf'
call plug#end()



"https://github.com/nvim-lua/completion-nvim#recommended-setting
"
"autocmd BufEnter * lua require'completion'.on_attach()
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"imap <silent> <c-p> <Plug>(completion_trigger)
"imap <tab> <Plug>(completion_smart_tab)
"imap <s-tab> <Plug>(completion_smart_s_tab)
"set completeopt=menuone,noinsert,noselect





lua << EOF
require'lspconfig'.clangd.setup{}
EOF

lua <<EOF
require "lsp_signature".setup()
EOF


lua<<EOF
require("dapui").setup()
EOF

lua<<EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF



autocmd BufEnter * COQnow



set virtualedit=all " can edit anywhere.

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
"colorscheme solarized8
"colorscheme C64
colorscheme badwolf

set background=dark
set tabstop=2
set shiftwidth=2
set expandtab    


set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h11

"" Conjure

let mapleader=" "
let g:coc_global_extensions = ['coc-conjure']
let maplocalleader = ","
let g:conjure#mapping#eval_current_form = "er"
let g:conjure#mapping#eval_root_form = "ee"
let g:conjure#mapping#def_word = "d"
let g:conjure#mapping#eval_visual = "E"
let g:conjure#mapping#eval_motion = "E"

inoremap jk <Esc>
"tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
nmap <silent> gd <Plug>(coc-definition)


au BufRead,BufNewFile *.mlir set syntax=c

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <C-h> <cmd>lua require('telescope.builtin').help_tags()<cr>



" Find files using Telescope command-line sugar.
"dired
"nnoremap <C-p> <cmd>Telescope git_files<CR>
"nnoremap <C-f> <cmd>Telescope file_browser<CR>
"nnoremap <C-s> <cmd>Telescope grep_string<CR>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"nnoremap <leader>fs <cmd>Telescope lsp_workspace_symbols<cr>


"source /home/bollu/dotfiles/digraph.vim

"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

"copen: open quickfix. Mnemonic: 'cope' with the error
