set -gx MISE_ACTIVATE_AGGRESSIVE true
set -gx MISE_EXPERIMENTAL true
set -gx MISE_DEFAULT_CONFIG_FILENAME .mise.local.toml
set -gx MISE_IDIOMATIC_VERSION_FILE_ENABLE_TOOLS node,python
set -gx MISE_GO_SET_GOBIN false
if command -sq mise; and test -z "$MISE_SHELL"
    mise activate fish | source
end
