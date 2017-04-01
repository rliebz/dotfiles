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
