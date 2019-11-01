# NVM Configuration
if [[ -f /usr/local/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  source "/usr/local/opt/nvm/nvm.sh"
fi

# Yarn Configuration
if command -v yarn &> /dev/null; then
  # Keep global binaries global
  if test -f "$HOME/.yarnrc" && ! grep -q prefix "$HOME/.yarnrc"; then
    yarn config set prefix "$HOME/.yarn"
  fi

  export PATH="$(yarn global bin):${PATH}"
fi
