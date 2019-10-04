# Load local secrets first
[[ -f ~/.secrets.local ]] && source ~/.secrets.local

# Load ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post, in order
_load_settings() {
  local _dir="$1"

  if [[ -d "${_dir}" ]]; then

    # Load pre-configurations
    if [[ -d "${_dir}/pre" ]]; then
      for config in "${_dir}"/pre/**/*(N-.); do
        source ${config}
      done
    fi

    # Load configurations
    for config in "${_dir}"/**/*(N-.); do
      case "${config}" in
        "${_dir}"/pre/*|"${_dir}"/post/*)
          :
          ;;
        *)
          [[ -f ${config} ]] && source ${config}
          ;;
      esac
    done

    # Load post-configurations
    if [[ -d "${_dir}/post" ]]; then
      for config in "${_dir}"/post/**/*(N-.); do
        source ${config}
      done
    fi

  fi
}

# Load configuration settings
_load_settings "${HOME}/.zsh/configs"

# Load local configuration settings
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
