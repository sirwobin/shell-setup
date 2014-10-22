#!/bin/bash

if [ -d ~/.vim ]; then
	echo Moving old ~/.vim directory to ~/.vim-old-$$
	mv ~/.vim ~/.vim-old-$$
fi

if [ -f ~/.vimrc ]; then
	echo Moving old ~/.vimrc file to ~/.vimrc-old-$$
	mv ~/.vimrc ~/.vimrc-old-$$
fi

if [ -f ~/.gvimrc ]; then
	echo Moving old ~/.gvimrc file to ~/.gvimrc-old-$$
	mv ~/.gvimrc ~/.gvimrc-old-$$
fi

echo Creating bundle directory.
mkdir -p ~/.vim/bundle

echo Cloning bundle git repos.
cd ~/.vim/bundle
git clone git@github.com:tpope/vim-pathogen.git
git clone git@github.com:kien/rainbow_parentheses.vim.git
git clone git://github.com/tpope/vim-classpath.git
git clone git://github.com/tpope/vim-fireplace.git
git clone git://github.com/tpope/vim-commentary.git
git clone git@github.com:scrooloose/nerdtree.git
git clone git@github.com:guns/vim-clojure-static.git
# git clone https://github.com/vim-scripts/paredit.vim
git clone git@github.com:jordwalke/flatlandia.git
git clone git@github.com:bling/vim-airline.git
git clone git@github.com:tpope/vim-fugitive.git
git clone git@github.com:rking/ag.vim.git

echo Fetching .vimrc from git
curl -LSso ~/.vimrc https://github.com/robingl/vim-config/raw/master/vimrc

echo Fetching Inconsolata font for Powerline
curl -LSso "Inconsolata for Powerline.otf" "https://github.com/Lokaltog/powerline-fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf?raw=true"

echo Done.  Remember to install the font.
