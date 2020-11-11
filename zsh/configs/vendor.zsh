# Set man path
export MANPATH=${HOME}/.man:${MANPATH}

# asdf
source "${VENDOR_PATH}/asdf/asdf.sh"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# z (autojump)
source ${VENDOR_PATH}/z/z.sh
if ! [[ -f "${HOME}/.man/man1/z.1" ]]; then
    ln -s "${VENDOR_PATH}/z/z.1" "${HOME}/.man/man1/z.1"
fi

# Google Cloud SDK
if test -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi
