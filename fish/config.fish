if set -q fish_config_loaded
    exit
end
set -gx fish_config_loaded

set -gx fish_greeting

# Homebrew
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ENV_HINTS 1
if test -f /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# Go
set -gx GOPATH $HOME/.local/share/go
fish_add_path -mP $GOPATH/bin

# Rust
set -gx CARGO_HOME $HOME/.local/share/cargo
fish_add_path -mP $CARGO_HOME/bin

# XDG bin directory
fish_add_path -mP $HOME/.local/bin

# Mise
if command -sq mise
    mise activate fish | source
end

# Datadog
set -gx DD_TRACE_ENABLED false
set -gx DD_PROFILING_ENABLED false

# Docker
set -gx DOCKER_SCAN_SUGGEST false

# FZF
if command -sq fzf
    fzf --fish | source
end
set -gx FZF_DEFAULT_OPTS (string join " " -- "$FZF_DEFAULT_OPTS" --bind (
    string join , -- \
    ctrl-u:half-page-up \
    ctrl-d:half-page-down \
))

# zoxide
if command -sq zoxide
    zoxide init fish | source
end

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

# Force mise to reassess paths
touch ~/.config/mise/config.toml
