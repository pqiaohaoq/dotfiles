#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1='\u@\h at \[\e[32m\]\w \[\e[91m\]$(parse_git_branch)\[\e[00m\]\$ '

[[ ${TERM} == "xterm-termite" ]] && export TERM=xterm-256color

command -v nvim &> /dev/null && export EDITOR=nvim
command -v lsd &> /dev/null && alias ls="lsd --header"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=11000
export HISTFILESIZE=11000
export HISTCONTROL=ignoredups:erasedups

export HOMEBREW_EDITOR=${EDITOR}
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"

export GO11MODULE=on
export GOPATH=${HOME}/.go
export GOPROXY=https://goproxy.cn,direct

export RUSTUP_UPDATE_ROOT=https://mirrors.aliyun.com/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.aliyun.com/rustup

export FZF_DEFAULT_OPTS="--height=20% --reverse"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --exclude={.git,build,thirdparty,vendor}"

function add_path() {
    export PATH=${PATH}:$1
}
add_path "${GOPATH}/bin"
add_path "${HOME}/.local/bin"
add_path "${HOME}/.node_modules/bin"
add_path /usr/local/sbin # for homebrew bin

# copied from https://bit.ly/3ZhgVjz
function fssh() {
    host=$(grep "^Host " ${HOME}/.ssh/config | cut -b 6- | fzf --prompt="SSH > " --preview="awk -v HOST={} -f ~/.ssh/host2conf.awk ~/.ssh/config")
    [ $? -eq 0 ] && ssh ${host}
}

function fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias bashconfig="source ${HOME}/.bashrc"
alias ll="ls -lh"
alias la="ll -a"
alias brewfile="brew bundle dump --global -f"

# only for macos java installed by brew
if [[ $(uname -o) == "Darwin" ]]; then
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
    export CPPFLAGS="-I/usr/local/opt/openjdk/include"
fi
