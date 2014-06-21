runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme flatlandia

syntax on
filetype plugin indent on
set guitablabel=%M%t
set number
set wildmode=full
set guifont=Courier\ New:h14
set cindent
set shiftwidth=2
set expandtab
let mapleader = ','
command BigFont set guifont=Courier\ New:h16
command SmallFont set guifont=Courier\ New:h14

" behave mswin

" To change tab using Cmd-{ and Cmd-}
" macm Window.Select\ Previous\ Tab  key=<D-S-Left>
" macm Window.Select\ Next\ Tab  key=<D-S-Right>

" Map Cmd-Number to go to that tab number
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt

" Map Cmd-Number to go to that tab number when in insert mode too.
imap <D-1> <C-O>1gt
imap <D-2> <C-O>2gt
imap <D-3> <C-O>3gt
imap <D-4> <C-O>4gt
imap <D-5> <C-O>5gt
imap <D-6> <C-O>6gt

" Rainbow parens
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Set vim-clojure-static indentation options
let g:clojure_align_multiline_strings = 1


cd ~/Projects

