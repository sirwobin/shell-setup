let mapleader = ','
let localleader = '\\'

call plug#begin(stdpath('data') . '/plugged')

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.3.1'}

" Conjure support - jack-in with nrepl dependencies
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
" Only in Neovim:
Plug 'radenling/vim-dispatch-neovim'

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'romgrk/barbar.nvim'

call plug#end()

if has('win32')
  " Turn on <C-c> <C-v> for copy/paste
  source $VIMRUNTIME/mswin.vim
endif

" Load all other vim files in the config directory that are not init.vim or ginit.vim
for f in split(glob(stdpath('config').'/*'), "\n")
  if f !~ '[\\\/]g\=init.vim$' && f =~ '\(lua\|vim\)$'
    execute 'source' f
  endif
endfor
" colorscheme flatlandia

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
highlight CursorLine term=underline ctermbg=238 guibg=#4C4C4C guisp=#36393c
" highlight Cursor guifg=white guibg=darkblue
command FixTrailingSpaces %s/\s\+$//

nnoremap <silent> <Leader>0 :nohl<Enter>
nnoremap <silent> <Leader>a /<C-R><C-W><Enter>
nnoremap <silent> <Leader>s :w<Enter>
nnoremap <silent> <Leader>t :NvimTreeToggle<Enter>
nnoremap <silent> <Leader>y "*y
nnoremap <silent> <Leader>p "*p
imap jj <Esc>

" Ctrl-Space now omnicompletes as well
noremap <C-Space> <C-x><C-o>

