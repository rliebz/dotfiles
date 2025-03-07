set -g fish_greeting

# XDG bin directory
fish_add_path -P $HOME/.local/bin

# Homebrew
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ENV_HINTS 1
fish_add_path -P /opt/homebrew/bin

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

# Go
set -gx GOPATH $HOME/.local/share/go
fish_add_path -P $GOPATH/bin

# Rust
set -gx CARGO_HOME $HOME/.local/share/cargo
fish_add_path -P $CARGO_HOME/bin

# zoxide
if command -sq zoxide
    zoxide init fish | source
end

# Mise
set -gx MISE_ACTIVATE_AGGRESSIVE true
set -gx MISE_EXPERIMENTAL true
set -gx MISE_DEFAULT_CONFIG_FILENAME .mise.local.toml
set -gx MISE_GO_SET_GOBIN false
if command -sq mise; and test -z "$MISE_SHELL"
    mise activate fish | source
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
