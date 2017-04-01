# Makes color constants available
autoload -U colors
colors

# Enable colored output from ls, etc. on FreeBSD-based systems
# For GNU-based systems, an alias must be set. See aliases.zsh
export CLICOLOR=1

# Set GNU colors to match BSD defaults
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
