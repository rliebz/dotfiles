# Set default options for command line utils
alias cp='nocorrect cp -i'
alias ln='nocorrect ln -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm'

# Allow upward navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
