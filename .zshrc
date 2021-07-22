# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lang
export LANG=ja_JP.UTF-8
export LC_CTYPE=en_US.UTF-8

# Editorをnvimに
export EDITOR=nvim

# $PATHの重複をなくす
typeset -U path cdpath fpath manpath

# alias
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
if type lsd &> /dev/null
then
   alias ls='lsd'
   alias la='lsd -a'
   alias ll='lsd -l'
   alias lla='lsd -la'   
fi
if type bat &> /dev/null
then
    alias cat='bat'
fi
if type nvim &> /dev/null
then
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi
if type gomi &> /dev/null
then
    alias rm=gomi
fi

# Cで標準出力をクリップボードへ
alias  pbcopy='clip.exe'

#ライン操作をVim
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# text object
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# 自動補完を有効化
fpath+=~/.zfunc
autoload -U compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
# キャッシュを利用して補完を高速化
zstyle ':completion::complete:*' use-cache true
# 補完候補の可視化
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' menu select=long
# コマンドの文脈に応じた補完
zstyle ':completion:*' completer _expand _complete _correct _match _prefix _approximate _list _history
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
# rehash不要にする
zstyle ":completion:*:commands" rehash 1
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完でカラーを使用
autoload colors
eval $(dircolors ~/.dir_colors)
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
# killの候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 何も入力されていないときのTABでTABが挿入されるのを抑制
zstyle ':completion:*' insert-tab false

# 履歴設定
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 履歴の一覧を読みやすい形に変更
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

# 補完リストが多いときは補完しない
LISTMAX=1000

#入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# BEEPを鳴らさない
setopt NO_BEEP
# !!などを実行する前に確認する
setopt HISTVERIFY
# 余分な空白は詰めて記録
setopt HIST_IGNORE_SPACE
# 履歴ファイルを上書きでなく追加に
setopt APPEND_HISTORY
# 履歴に時刻情報もつける
setopt EXTENDED_HISTORY
# 履歴がいっぱいの時は最も古いものから削除
setopt HIST_EXPIRE_DUPS_FIRST
# 履歴検索中、重複を飛ばす
setopt HIST_FIND_NO_DUPS
# 履歴リストから関数定義を除く
unsetopt HIST_NO_FUNCTIONS
# 前のコマンドと同じなら履歴に入れない
setopt HIST_IGNORE_DUPS
# 重複する履歴を持たない
setopt HIST_IGNORE_ALL_DUPS
# 実行前に展開結果を確認
setopt HIST_VERIFY
#履歴をインクリメンタルに追加
setopt INC_APPEND_HISTORY
# historyコマンドを履歴に入れない
unsetopt HIST_NO_STORE
# 履歴から冗長な空白を除く
setopt HIST_REDUCE_BLANKS
# 履歴を共有
setopt SHARE_HISTORY
# 古いコマンドと同じものは無視
setopt HIST_SAVE_NO_DUPS
# 補完時にヒストリを自動的に展開する
setopt HIST_EXPAND
# 補完候補が複数ある時に、一覧表示
setopt AUTO_LIST
# 補完キー(Tab)を連打するだけで順に補完候補を自動で補完
setopt AUTO_MENU

# ディレクトリ名だけで移動
setopt AUTO_CD
# Ctrl+Dでzshを終了しない
setopt IGNORE_EOF
# '#'以降をコメントとして扱う
setopt INTERACTIVE_COMMENTS
# globのメタ文字対策
setopt NONOMATCH


# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Two regular plugins loaded without tracking.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q

# Plugin history-search-multi-word loaded with tracking.
zinit load zdharma/history-search-multi-word

# Plugin history-substring-search loaded with tracking.
zinit load zsh-users/zsh-history-substring-search

# Visual mode in Zsh Line Editer
zinit load b4b4r07/zsh-vimode-visual

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ls after cd
chpwd() {
    ls
}

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# cd ..
function __zsh_up_cd() {
    local BUF=${BUFFER}
    zle kill-whole-line

    BUFFER="cd .."

    zle .accept-line

    if [ ! ${#BUF} -eq 0 ];then
        zle -U ${BUF}
    fi
}
zle -N __zsh_up_cd
bindkey '^U' __zsh_up_cd

# search history
function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco --prompt="history >"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# peco cdr
function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^H' peco-cdr

# search ghq repository
function peco-ghq-look () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-look
bindkey '^J' peco-ghq-look

# search pet snippet
function pet-search () {
    local snippet="$(pet search)"
    if [ -n "$snippet" ];then
        BUFFER=$snippet
    fi
}
zle -N pet-search
bindkey '^P' pet-search

# peco new command used most recently
function pet-prev() {
    PREV=$(fc -lrn | head -n 1)
    sh -c "pet new `printf %q "$PREV"`"
}

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# golang
export GOENV_DISABLE_GOPATH=1
export GOPATH="$HOME/work"
export GOBIN="$HOME/work/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"

# ghg
export PATH="$(ghg bin):$PATH"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

# opam configuration
test -r /home/reeve0930/.opam/opam-init/init.zsh && . /home/reeve0930/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
