# Set vendor path
VENDOR_PATH=${HOME}/.zsh/vendor

# Z (autojump)
source ${VENDOR_PATH}/z/z.sh
if ! [[ -f /usr/local/share/man/man1/z.1 ]]; then
    ln -s ${VENDOR_PATH}/z/z.1 /usr/local/share/man/man1
fi

# zsh-completions
fpath+="${VENDOR_PATH}/zsh-completions/src"
