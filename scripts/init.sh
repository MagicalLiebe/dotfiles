#!/bin/sh

echo "初期設定を開始"

cd ~

# anyenvのインストール
git clone https://github.com/anyenv/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
yes | anyenv install --init
eval "$(anyenv init -)"

# anyenv-updateのインストール
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# goenvのインストール
anyenv install goenv
goenv install 1.16.0
goenv global 1.16.0

export GOENV_DISABLE_GOPATH=1
export GOPATH="$HOME/work"
export GOBIN="$HOME/work/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export GO111MODULE=on

# ghgのインストール
go get github.com/Songmu/ghg/cmd/ghg
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
sudo apt install build-essential software-properties-common zsh silversearcher-ag zlib1g-dev libssl-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev

# Zinitのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# dein.vimのインストール
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ~/installer.sh ~/.cache/dein
rm ~/installer.sh

# pyenv/virtualenvのインストール
anyenv install pyenv
CONFIGURE_OPTS="--enable-shared" CFLAGS="-fPIC" pyenv install 3.9.2
CONFIGURE_OPTS="--enable-shared" CFLAGS="-fPIC" pyenv install 2.7.18
pyenv global 3.9.2
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# Poetryのインストール
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# rbenvのインストール
anyenv install rbenv
rbenv install 2.7.2
rbenv global 2.7.2

# plenvのインストール
anyenv install plenv
plenv install 5.32.1
plenv global 5.32.1
plenv install-cpanm

# Voltaのインストール
curl https://get.volta.sh | bash

# Node.js/yarnのインストール
volta install node@14
volta install yarn

# Neovim用環境の構築
# Python
pyenv virtualenv 2.7.18 neovim2
pyenv virtualenv 3.9.2 neovim3

pyenv activate neovim3
pip install --upgrade pip
pip install pynvim
pip install flake8 autopep8 black isort

pyenv activate neovim2
pip install --upgrade pip
pip install pynvim

pyenv deactivate

# Ruby
gem install neovim

# Perl
cpanm -n Neovim::Ext

# Node.js
yarn global add neovim
