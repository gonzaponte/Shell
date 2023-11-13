# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

####OLD
#. $HOME/.nix-profile/etc/profile.d/nix.sh

eval "$(direnv hook bash)"
eval "$(direnv hook  zsh)"
