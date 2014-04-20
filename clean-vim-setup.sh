#!/bin/bash

if [ -d ~/.vim ]; then
	echo Moving old ~/.vim directory to ~/.vim-old-$$
	mv ~/.vim ~/.vim-old-$$
fi

if [ -f ~/.vimrc ]; then
	echo Moving old ~/.vimrc file to ~/.vimrc-old-$$
	mv ~/.vimrc ~/.vimrc-old-$$
fi

echo Creating bundle directory.
mkdir -p ~/.vim/bundle

echo Cloning bundle git repos.
cd ~/.vim/bundle
git clone git@github.com:jordwalke/flatlandia.git
git clone git@github.com:scrooloose/nerdtree.git
git clone https://github.com/vim-scripts/paredit.vim
git clone git@github.com:kien/rainbow_parentheses.vim.git
git clone git://github.com/tpope/vim-classpath.git
git clone git@github.com:guns/vim-clojure-static.git
git clone git://github.com/tpope/vim-fireplace.git
git clone git@github.com:tpope/vim-pathogen.git


