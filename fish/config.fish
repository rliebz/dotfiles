set -g fish_greeting

# Editor defaults
if command -sq nvim
    set -gx EDITOR nvim
else if command -sq vim
    set -gx EDITOR vim
end
set -gx VISUAL $EDITOR

# Pager defaults
set -gx PAGER less
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'

# Docker
set -gx DOCKER_BUILDKIT 1
set -gx COMPOSE_DOCKER_CLI_BUILD 1
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
fish_add_path -g $HOME/.cargo/bin

# Yarn
if command -sq yarn
    set -l yarnrc $HOME/.yarnrc
    set -l config_dir $HOME/.local/share/yarn

    # Keep global binaries global
    if test -f $yarnrc && ! grep -q prefix $yarnrc
        yarn config set prefix $config_dir
        mkdir -p $config_dir/bin
    end

    fish_add_path -g $config_dir/bin
end

# pipx executable location
fish_add_path -g $HOME/.local/bin

# ASDF
#
# We want this last because it puts asdf at the front of our path
source $HOME/.dotfiles/asdf/asdf.fish
