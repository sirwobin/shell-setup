let mapleader = ','
let localleader = '\\'

set termguicolors
set t_Co=256

call plug#begin(stdpath('data') . '/plugged')

Plug 'hzchirs/vim-material'
Plug 'Everblush/everblush.vim'
" Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.37.0'}
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'clojure-vim/vim-jack-in'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'gpanders/nvim-parinfer'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'PaterJason/cmp-conjure'
Plug 'hrsh7th/nvim-cmp'
Plug 'p00f/nvim-ts-rainbow'

Plug 'nvim-lualine/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
call plug#end()

if has('win32')
  " Turn on <C-c> <C-v> for copy/paste
  source $VIMRUNTIME/mswin.vim
endif

" colorscheme everblush
let g:material_style='oceanic'
set background=dark
colorscheme vim-material

" let g:indentLine_char = ''
" let g:indentLine_first_char = ''
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 1

" Load all other vim files in the config directory that are not init.vim or ginit.vim
for f in split(glob(stdpath('config').'/*'), "\n")
  if f !~ '[\\\/]g\=init.vim$' && f =~ '\(lua\|vim\)$'
    execute 'source' f
  endif
endfor

" let g:conjure#mapping#dc_word = 'gk'

syntax on
filetype plugin indent on
set number
set wildmode=full
set cindent
set shiftwidth=2
set expandtab
set incsearch
set hlsearch
set cursorline
set visualbell
set mouse+=a
set completeopt=menu,menuone,noselect

" originally highlight CursorLine term=underline ctermbg=238 guibg=#2d3033 guisp=#36393c
"highlight CursorLine term=underline ctermbg=238 guibg=#4C4C4C guisp=#36393c
" highlight Cursor guifg=white guibg=darkblue
command FixTrailingSpaces %s/\s\+$//
command JsonFormat :%!python3 -m json.tool<Enter>
command NameTreeSitterTextObject execute "lua print(vim.treesitter.get_node_at_cursor())"
command EALamdaRepl execute "ConjureEval (shadow.cljs.devtools.api/repl :external-api-lambda)"
command CTMLamdaRepl execute "ConjureEval (shadow.cljs.devtools.api/repl :customer-token-manager-lambda)"
command GP Git push

nnoremap <silent> <Leader>0 :nohl<Enter>
nnoremap <silent> <Leader>a /<C-R><C-W><Enter>
nnoremap <silent> <Leader>s :w<Enter>
nnoremap <silent> <Leader>t :NvimTreeToggle<Enter>
nnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>o :GFiles<Enter>
inoremap <silent> <C-p> <plug>(fzf-complete-path)
imap jj <Esc>

