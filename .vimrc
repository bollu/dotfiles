"https://github.com/nanotee/nvim-lua-guide
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'arthurxavierx/vim-unicoder'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim' "coros
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ray-x/lsp_signature.nvim'
"Plug 'kosayoda/nvim-lightbulb'  "show lightbulb when LSP action is available
Plug 'ms-jpq/coq_nvim' "automcoplete via LSP
"Plug 'folke/trouble.nvim' "trouble bar
Plug 'nvim-lua/completion-nvim'


Plug 'windwp/nvim-spectre' "search and replacec
Plug 'mhinz/vim-startify'
Plug 'rktjmp/paperplanes.nvim' " :PP to send to pastebin
Plug 'airblade/vim-rooter' "setup project root


"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} -- snippets
"Plug 'stevearc/aerial.nvim' " minimap of file

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
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
"Plug 'rhysd/vim-clang-format'
"Plug 'cormacrelf/vim-colors-github'
"Plug 'sheerun/vim-polyglot'
"Plug 'vlime/vlime'
Plug 'sjl/badwolf'
Plug 'Julian/lean.nvim'
call plug#end()


let g:rooter_patterns = ['.git']

" lua << EOF
" require("trouble").setup{
"     fold_open = "v", -- icon used for open folds
"     fold_closed = ">", -- icon used for closed folds
"     indent_lines = false, -- add an indent guide below the fold icons
"     signs = {
"         -- icons / text used for a diagnostic
"         error = "error",
"         warning = "warn",
"         hint = "hint",
"         information = "info"
"     },
"     use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
"   }
" EOF



lua << EOF
require'lspconfig'.clangd.setup{}
EOF

lua <<EOF
require "lsp_signature".setup()
EOF


lua<<EOF
require("dapui").setup()
EOF


"keep sidebar always open
set signcolumn=yes:1

lua<<EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
    })


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>T', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
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


lua<<EOF
require('lean').setup{
  abbreviations = { builtin = true },
  lsp = { on_attach = on_attach },
  lsp3 = { on_attach = on_attach },
  mappings = true,
  infoview = {
    -- Automatically open an infoview on entering a Lean buffer?
    autoopen = true,
    -- Set the infoview windows' starting widths
    width = 50,
    -- Set the infoview windows' starting heights
    -- (portrait windows are split horizontally)
    height = 20,
  },

}
EOF



autocmd BufEnter * COQnow


set virtualedit=all " can edit anywhere.

set clipboard+=unnamedplus
let mapleader = " "
nnoremap <Tab> :bn!<CR>
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
"colorscheme delek
colorscheme gruvbox
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
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <C-h> <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader><leader> :lua require('spectre').open()<CR>
nnoremap <leader>S :lua require('spectre').open()<CR>
"search current word
nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

" Find files using Telescope command-line sugar.
"dired
"nnoremap <C-p> <cmd>Telescope git_files<CR>
"nnoremap <C-f> <cmd>Telescope file_browser<CR>
"nnoremap <C-s> <cmd>Telescope grep_string<CR>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"nnoremap <leader>fs <cmd>Telescope lsp_workspace_symbols<cr>

"c-x c-o: open auto complete
let g:opamshare = "/home/bollu/.opam/4.12.0/share"
execute "set rtp+=" . g:opamshare . "/merlin/vim"
autocmd FileType ocaml source /home/bollu/.opam/4.12.0/share/ocp-indent/vim/indent/ocaml.vim
