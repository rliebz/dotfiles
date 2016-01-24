setopt promptsubst

prompt_theme=(
  cyan
  green
  magenta
)

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
    echo "[%{$fg[${prompt_theme[2]}]%}${current_branch}%{$reset_color%}]"
  fi
}


# Echo symbols and space to prompt user input
separator() {
  echo "%{$fg_bold[${prompt_theme[3]}]%}|▶%{$reset_color%} "
}


# Prompt format
PS1='$(prompt_pwd) $(git_prompt_info)$(separator)'
