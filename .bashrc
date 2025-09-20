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

export GO11MODULE=on
export GOPATH=${HOME}/.go

export FZF_DEFAULT_OPTS="--height=20% --reverse"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --exclude={.git,build,thirdparty,vendor}"

export DOCKER_BUILDKIT=1
export COMPOSE_BAKE=true
export BUILDX_EXPERIMENTAL=1

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

fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview="bat --color=always {}"))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

