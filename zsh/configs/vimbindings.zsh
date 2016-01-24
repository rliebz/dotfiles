# Set command line keys to vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# Add useful keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^Y" yank
bindkey "^[f" forward-word    # alt-right
bindkey "^[b" backward-word   # alt-left

# Reduce mode change lag
export KEYTIMEOUT=1
