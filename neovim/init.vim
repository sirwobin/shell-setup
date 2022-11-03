let mapleader = ','
let localleader = '\\'

call plug#begin(stdpath('data') . '/plugged')

Plug 'Everblush/everblush.vim'
Plug 'tpope/vim-fugitive'

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.37.0'}
" Conjure support - jack-in with nrepl dependencies
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'clojure-vim/vim-jack-in'
Plug 'luochen1990/rainbow'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'gpanders/nvim-parinfer'
Plug 'mfussenegger/nvim-lint'

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

colorscheme everblush
set termguicolors
set t_Co=256

" Load all other vim files in the config directory that are not init.vim or ginit.vim
for f in split(glob(stdpath('config').'/*'), "\n")
  if f !~ '[\\\/]g\=init.vim$' && f =~ '\(lua\|vim\)$'
    execute 'source' f
  endif
endfor

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

" originally highlight CursorLine term=underline ctermbg=238 guibg=#2d3033 guisp=#36393c
"highlight CursorLine term=underline ctermbg=238 guibg=#4C4C4C guisp=#36393c
" highlight Cursor guifg=white guibg=darkblue
command FixTrailingSpaces %s/\s\+$//
command JsonFormat :%!python3 -m json.tool<Enter>
command LamdaRepl execute "ConjureEval (shadow.cljs.devtools.api/repl :lambda)"
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

" Ctrl-Space now omnicompletes as well
noremap <C-Space> <C-x><C-o>

