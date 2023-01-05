cd ~/.config
ln -s ~/projects/shell-setup/neovim/ nvim
mkdir nixpkgs
cd nixpkgs
ln -s ~/projects/shell-setup/nix/home.nix .
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# wireguard
cd /root
umask 077
mkdir wireguard-keys
wg genkey > wireguard-keys/private
wg pubkey < wireguard-keys/private > wireguard-keys/public

