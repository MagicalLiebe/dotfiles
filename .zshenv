export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH
export GO111MODULE=on

export PATH="$(ghg bin):$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
    source "${VIRTUAL_ENV}/bin/activate"
fi

export PATH="$HOME/.poetry/bin:$PATH"
