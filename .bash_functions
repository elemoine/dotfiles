# Function to search for passwords in my password store
function spass {
    pushd ${HOME}/.password-store > /dev/null
    password=$(find . -name '*.gpg' | fzf)
    popd > /dev/null
    password=${password%.*}
    pass show $@ $password
}
