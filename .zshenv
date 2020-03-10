export PATH="$HOME/bin:$PATH"

# Lang
# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Golang
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/work"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# Python
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

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# tools
# ghg
export PATH="$(ghg bin):$PATH"

#CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
