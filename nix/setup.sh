cd ~/.config
ln -s ~/projects/shell-setup/neovim/ nvim
mkdir home-manager
cd home-manager
ln -s ~/projects/shell-setup/nix/home.nix .
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cd ~/.local
ln -s ~/projects/shell-setup/bin .

# yubikey
nix-shell -p pam_u2f pamtester
mkdir -p ~/.config/Yubico
pamu2fcfg > .config/Yubico/u2f_keys
pamtester sudo robin authenticate

# wireguard
cd /root
umask 077
mkdir wireguard-keys
wg genkey > wireguard-keys/private
wg pubkey < wireguard-keys/private > wireguard-keys/public

