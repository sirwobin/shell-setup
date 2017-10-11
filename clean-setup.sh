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
git clone https://github.com/tpope/vim-pathogen
git clone https://github.com/kien/rainbow_parentheses.vim
git clone https://github.com/tpope/vim-classpath
git clone https://github.com/tpope/vim-fireplace
git clone https://github.com/tpope/vim-commentary
git clone https://github.com/tpope/vim-repeat
git clone https://github.com/guns/vim-sexp
git clone https://github.com/tpope/vim-sexp-mappings-for-regular-people
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/guns/vim-clojure-static
git clone https://github.com/danhart/flatlandia.git
git clone https://github.com/bling/vim-airline
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/rking/ag.vim
git clone https://github.com/bkad/CamelCaseMotion
git clone https://github.com/fidian/hexmode.git

echo Fetching .vimrc from git
curl -LSso ~/.vimrc https://github.com/robingl/shell-setup/raw/master/vimrc

echo Fetching Inconsolata font for Powerline
curl -LSso "Inconsolata for Powerline.otf" "https://github.com/Lokaltog/powerline-fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf?raw=true"

echo Done vim setup.  Remember to install the font.

echo Fetching oh my zsh.
curl -L http://install.ohmyz.sh | sh

echo Fetching .zshrc from git
curl -LSso ~/.zshrc https://github.com/robingl/shell-setup/raw/master/zshrc

echo Fetching patched powerline theme from git
curl -LSso ~/.oh-my-zsh/themes/powerline.zsh-theme https://github.com/robingl/shell-setup/raw/master/powerline.zsh-theme

echo Fetching .slate from git
curl -LSso ~/.slate https://github.com/robingl/shell-setup/raw/master/slate
echo Copying AppleScript utilities
curl -LSso ~/Library/Mobile\ Documents/com\~apple\~ScriptEditor2/Documents/LockScreen.scpt https://github.com/robingl/shell-setup/raw/master/LockScreen.scpt
curl -LSso ~/Library/Mobile\ Documents/com\~apple\~ScriptEditor2/Documents/MoveMouseToFocus.scpt https://github.com/robingl/shell-setup/raw/master/MoveMouseToFocus.scpt

echo Installing cliclick
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cliclick

echo "All done. :-)"

