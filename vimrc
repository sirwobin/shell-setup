runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme flatlandia

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
" originally highlight CursorLine term=underline ctermbg=238 guibg=#2d3033 guisp=#36393c
highlight CursorLine term=underline ctermbg=238 guibg=#4C4C4C guisp=#36393c
let mapleader = ','
command FixTrailingSpaces %s/\s\+$//

nnoremap <Leader>0 :nohl<Enter>
nnoremap <Leader>a /<C-R><C-W><Enter>
nnoremap <Leader>s :w<Enter>
nnoremap <Leader>t :NERDTreeToggle<Enter>
nnoremap <Leader>1 :w<Enter>:bp<Enter>
nnoremap <Leader>2 :w<Enter>:bn<Enter>
nnoremap <Leader>3 :w<Enter>:bd<Enter>
imap jj <Esc>

" Ctrl-Space now omnicompletes as well
inoremap <C-Space> <C-x><C-o>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2  " Show the status line

if has('clipboard')
  set clipboard=unnamed
endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if has("gui_running")
  set guitablabel=%M%t

  if has("gui_gnome")
    set guifont=Inconsolata\ for\ Powerline\ 14

    command BigFont set guifont=Inconsolata\ for\ Powerline\ 16
    command MidFont set guifont=Inconsolata\ for\ Powerline\ 14
    command SmallFont set guifont=Inconsolata\ for\ Powerline\ 12

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
  elseif has("gui_mac")
    set guifont=Inconsolata\ for\ Powerline:h16

    command BigFont set guifont=Inconsolata\ for\ Powerline:h22
    command MidFont set guifont=Inconsolata\ for\ Powerline:h18
    command SmallFont set guifont=Inconsolata\ for\ Powerline:h16

    nnoremap <Leader>f :set fullscreen<Enter>
    nnoremap <Leader>F :set nofullscreen<Enter>
    nnoremap <D-1> :w<Enter>:bp<Enter>
    inoremap <D-1> <Esc>:w<Enter>:bp<Enter>
    nnoremap <D-2> :w<Enter>:bn<Enter>
    inoremap <D-2> <Esc>:w<Enter>:bn<Enter>
    nnoremap <D-3> :w<Enter>:bd<Enter>
  endif

  let g:airline_powerline_fonts = 1
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    " add --hidden to include hidden files in ctrlp file list.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Rainbow parens
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Set vim-clojure-static indentation options
let g:clojure_align_multiline_strings = 1

cd ~/Projects

