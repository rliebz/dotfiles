set -g fish_greeting

# Editor defaults
if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end

# Pager defaults
set -gx PAGER less
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'

# Fast upward directory navigation
function __multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function __multicd

# XDG bin directory
fish_add_path -g $HOME/.local/bin

# Docker
set -gx DOCKER_SCAN_SUGGEST false

# FZF
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --bind ctrl-a:select-all,ctrl-d:deselect-all"

# Go
set -gx GOPATH $HOME/.local/share/go
fish_add_path -g $GOPATH/bin

# Homebrew
fish_add_path -g /opt/homebrew/bin
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ENV_HINTS 1

# Rust
set -gx CARGO_HOME $HOME/.local/share/cargo
fish_add_path -g $CARGO_HOME/bin

# ASDF
#
# We want this last because it puts asdf at the front of our path
set -gx ASDF_CONFIG_FILE $HOME/.config/asdf/.asdfrc
set -gx ASDF_DATA_DIR $HOME/.local/share/asdf
set -gx ASDF_GOLANG_MOD_VERSION_ENABLED false
source $HOME/.dotfiles/asdf/asdf.fish
