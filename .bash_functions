# Function to search for passwords in my password store
function spass {
    pushd ${HOME}/.password-store > /dev/null
    password=$(find . -name '*.gpg' | fzf)
    popd > /dev/null
    password=${password%.*}
    pass show $@ $password
}

function pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")"
    ;;
  *)
    command pyenv "$command" "$@"
    ;;
  esac
}
