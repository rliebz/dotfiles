set -g fish_greeting

# Editor defaults
if command -sq nvim
  set -gx EDITOR nvim
else if command -sq vim
  set -gx EDITOR vim
end
set -gx VISUAL $EDITOR

# Pager defaults
set -gx PAGER less
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'
