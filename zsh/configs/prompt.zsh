setopt promptsubst

prompt_theme=(
  cyan
  green
  magenta
  yellow
)

# Echo user and machine if ssh
prompt_ssh() {
  if [[ -n "${SSH_TTY}" ]]; then
      echo "%{$fg[blue]%}@%m%{$reset_color%}:"
  fi
}


# Echo abbreviated working directory
abbreviated_pwd() {
  local pwd="${PWD/#${HOME}/~}"

  if [[ "${pwd}" == (#m)[/~] ]]; then
    echo "${MATCH}"
    unset MATCH
  else
    echo "${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
}


# Echo abbreviated pwd in color
prompt_pwd() {
  echo "%{$fg_bold[${prompt_theme[1]}]%}$(abbreviated_pwd)%{$reset_color%}"
}


# Echo git branch name in brackets, or nothing
git_prompt_info() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n ${current_branch} ]]; then
    echo "[%{$fg[${prompt_theme[2]}]%}${current_branch}%{$reset_color%}$(git_branch_dirty)]"
  fi
}


# Echo star for dirty git branch
git_branch_dirty() {
  if ! [[ $(git status 2> /dev/null | tail -n1) =~ "nothing to commit" ]]; then
    echo "%{$fg_bold[${prompt_theme[4]}]%}*%{$reset_color%}"
  fi
}

# Echo symbols and space to prompt user input
separator() {
  echo "%{$fg_bold[${prompt_theme[3]}]%}|%{%G▶%}%{$reset_color%} "
}


# Prompt format
PS1='$(prompt_ssh)$(prompt_pwd) $(git_prompt_info)$(separator)'
