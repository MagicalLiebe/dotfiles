#!/bin/sh

echo "初期設定を開始"

# 開発用フォルダの作成
cd ~
mkdir -p work

# goenvのインストール
git clone https://github.com/syndbg/goenv.git ~/.goenv
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
export GOENV_DISABLE_GOPATH=1
eval "$(goenv init -)"

goenv install 1.14.4
goenv global 1.14.4
goenv rehash

export GOPATH="$HOME/work"
export PATH="$GOPATH/bin:$PATH"

# ghgのインストール
GO111MODULE=on go get github.com/Songmu/ghg/cmd/ghg
export PATH="$(ghg bin):$PATH"

# 便利なソフトのインストール
ghg get motemen/ghq
ghg get peco/peco
ghg get knqyf263/pet

# Neovimのインストール
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# 依存ライブラリをインストール
sudo apt install build-essential software-properties-common zsh silversearcher-ag zlib1g-dev libssl-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev

# Zinitのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# dein.vimのインストール
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ~/installer.sh ~/.cache/dein
rm ~/installer.sh

# pyenv/virtualenvのインストール
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
    source "${VIRTUAL_ENV}/bin/activate"
fi

# Python2.7と3.7環境の構築
CONFIGURE_OPTS="--enable-shared" CFLAGS="-fPIC" pyenv install 3.7.6
CONFIGURE_OPTS="--enable-shared" CFLAGS="-fPIC" pyenv install 2.7.17
pyenv global 3.7.6

# Neovim用環境の構築
# Python
pyenv virtualenv 2.7.17 neovim2
pyenv virtualenv 3.7.6 neovim3

pyenv activate neovim3
pip install --upgrade pip
pip install pynvim
pip install flake8 autopep8 black isort

pyenv activate neovim2
pip install --upgrade pip
pip install pynvim

pyenv deactivate

# Node.js
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt update
sudo apt install nodejs
sudo npm install -g neovim

# Ruby
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

CONFIGURE_OPTS='--disable-install-rdoc' rbenv install 2.7.0
rbenv global 2.7.0
gem install neovim
