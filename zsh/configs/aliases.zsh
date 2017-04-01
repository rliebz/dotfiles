# Set default options for command line utils
alias cp='nocorrect cp -i'
alias ln='nocorrect ln -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm'
if ls --color -d . &>/dev/null && ls -G . &>/dev/null; then
  alias ls='ls --color=tty -G'
elif ls --color -d . &>/dev/null && ls -G . &>/dev/null; then
  alias ls='ls --color=tty'
elif ls -G . &>/dev/null; then
  alias ls='ls -G'
fi

# Allow upward navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Never open vi
alias vi="vim"
