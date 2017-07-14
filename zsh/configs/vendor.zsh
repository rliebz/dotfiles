# Set vendor path
VENDOR_PATH=${HOME}/.zsh/vendor

# Set man path
export MANPATH=${HOME}/.man:${MANPATH}

# Z (autojump)
source ${VENDOR_PATH}/z/z.sh
if ! [[ -f ${HOME}/.man/man1/z.1 ]]; then
    ln -s ${VENDOR_PATH}/z/z.1 ${HOME}/.man/man1/z.1
fi

# zsh-completions
fpath+="${VENDOR_PATH}/zsh-completions/src"

# Google Cloud SDK
if test -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

# asdf
if [[ -f /usr/local/opt/asdf/asdf.sh ]]; then
  source /usr/local/opt/asdf/asdf.sh
fi

if [[ -f /usr/local/etc/bash_completion.d/asdf.bash ]]; then
  source /usr/local/etc/bash_completion.d/asdf.bash
fi
