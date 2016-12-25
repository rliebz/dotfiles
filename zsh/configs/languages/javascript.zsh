# Yarn configuration
if command -v yarn &> /dev/null; then
  if test -e ~/.yarnrc && ! grep -q prefix ~/.yarnrc; then
    mkdir -p /usr/local/lib/yarnpkg
    yarn config set prefix /usr/local/lib/yarnpkg &> /dev/null
  fi
  export PATH="$PATH:$(yarn global bin)"
fi
