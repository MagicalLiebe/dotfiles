#!/bin/sh

echo "初期設定を開始"

# 開発用フォルダの作成
cd ~
mkdir -p work

# Go言語環境の構築
wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH = "$HOME/work"
export PATH = "$GOPATH/bin:$PATH"
rm go1.13.6.linux-amd64.tar.gz

# ghgのインストール
go get github.com/Songmu/ghg/cmd/ghg
export PATH="$(ghg bin):$PATH"

# 便利なソフトのインストール
ghg get motemen/ghq
ghg get peco/peco
ghg get knqyf263/pet

# 依存ライブラリをインストール
sudo apt install build-essential software-properties-common zsh silversearcher-ag zlib1g-dev libssl-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev

# Zinitのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# Neovimのインストール
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

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
CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.6
CONFIGURE_OPTS="--enable-shared" pyenv install 2.7.17

# Neovim用環境の構築
pyenv virtualenv 2.7.17 neovim2
pyenv virtualenv 3.7.6 neovim3

pyenv activate neovim3
pip install --upgrade pip
pip install pynvim

pyenv activate neovim2
pip install --upgrade pip
pip install pynvim

pyenv deactivate
