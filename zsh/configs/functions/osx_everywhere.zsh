# Set open, pbcopy, and pbaste commands for other OSes
if [[ "$OSTYPE" == darwin* ]]; then
  :   # NOOP
elif [[ "${OSTYPE}" == cygwin* ]]; then
  alias open='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
else
  alias open='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi
