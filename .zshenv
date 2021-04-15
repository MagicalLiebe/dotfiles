export PATH="$HOME/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# Golang
export GOENV_DISABLE_GOPATH=1
export GOPATH="$HOME/work"
export GOBIN="$HOME/work/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export GO111MODULE=on

export PATH="$HOME/.poetry/bin:$PATH"

# ghg
export PATH="$(ghg bin):$PATH"

#CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# local
source "$HOME/.localrc"
