# Load custom completion functions
fpath=(
  ~/.zsh/zsh-completions
  /usr/local/share/zsh/site-functions
  ${fpath}
)

# Set completion
autoload -U compinit
compinit
