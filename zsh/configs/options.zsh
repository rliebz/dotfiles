# Impove cd behaviors
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Explicitly mention lack of filename generation matches
setopt nomatch

# Do not prompt the user for rm *
setopt rmstarsilent

# Don't make sounds
unsetopt beep

# Don't correct all arguments in a line
unsetopt correct_all
