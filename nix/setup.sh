cd ~/.config
ln -s ~/projects/shell-setup/neovim/ nvim
mkdir nixpkgs
cd nixpkgs
ln -s ~/projects/shell-setup/nix/home.nix .
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

