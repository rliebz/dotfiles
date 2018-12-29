# Set text editor to vim
if command -v nvim &> /dev/null; then
  export EDITOR='nvim'
elif command -v vim &> /dev/null; then
  export EDITOR='vim'
fi
export VISUAL="${EDITOR}"

# Set pager to less
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set tab size to 4
tabs -4

# Set language
export LANG=en_US.UTF-8
