# Yarn
if command -sq yarn
  # Keep global binaries global
  if test -f $HOME/.yarnrc && ! grep -q prefix $HOME/.yarnrc
    yarn config set prefix $HOME/.yarn
  end

  set -gx PATH (yarn global bin) $PATH
end
