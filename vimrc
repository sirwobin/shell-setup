runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme flatlandia

syntax on
filetype plugin indent on
set guitablabel=%M%t
set number
set wildmode=full
set guifont=Inconsolata\ for\ Powerline:h16
set cindent
set shiftwidth=2
set expandtab
set incsearch
set hlsearch
set cursorline
" originally highlight CursorLine term=underline ctermbg=238 guibg=#2d3033 guisp=#36393c
highlight CursorLine term=underline ctermbg=238 guibg=#4C4C4C guisp=#36393c
let mapleader = ','
command BigFont set guifont=Inconsolata\ for\ Powerline:h22
command SmallFont set guifont=Inconsolata\ for\ Powerline:h16
command FixTrailingSpaces %s/\s\+$//

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
" Show the status line
set laststatus=2

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    " add --hidden to include hidden files in ctrlp file list.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Apple-1 save and go to previous buffer
nnoremap <D-1> :w<Enter>:bp<Enter>
inoremap <D-1> <Esc>:w<Enter>:bp<Enter>
" Apple-2 save and go to next buffer
nnoremap <D-2> :w<Enter>:bn<Enter>
inoremap <D-2> <Esc>:w<Enter>:bn<Enter>
" Apple-3 save and close buffer in command mode only.
nnoremap <D-3> :w<Enter>:bd<Enter>

" Ctrl-Space now omnicompletes as well
inoremap <C-Space> <C-x><C-o>

" Rainbow parens
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Set vim-clojure-static indentation options
let g:clojure_align_multiline_strings = 1


cd ~/Projects

