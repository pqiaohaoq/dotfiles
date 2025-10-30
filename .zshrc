#!/usr/bin/env zsh

[[ $- != *i* ]] && return


setopt NO_BEEP
setopt PROMPT_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE


function git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /' }
PROMPT='%n@%m at %F{green}%~%f %F{red}$(git_branch)%f\$ '


command -v nvim &> /dev/null && export EDITOR=nvim
command -v lsd &> /dev/null && alias ls="lsd --header"


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

export HOMEBREW_EDITOR=${EDITOR}
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_INSTALL_FROM_API=1

export GO11MODULE=on
export GOPATH=${HOME}/.go

export DOCKER_BUILDKIT=1
export COMPOSE_BAKE=true
export BUILDX_EXPERIMENTAL=2


function add_path() {
    export PATH=${PATH}:$1
}
add_path "${GOPATH}/bin"
add_path "${HOME}/.local/bin"
add_path "${HOME}/.node_modules/bin"
add_path "/usr/local/bin" # for homebrew bin


alias brewfile="brew bundle dump --global -f"


function fco() {
    local tags branches target
    branches=$(git --no-pager branch --all --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" | sed '/^$/d') || return
    tags=$(git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
    target=$((echo "${branches}"; echo "${tags}") | fzf --no-hscroll --no-multi -n 2 --ansi) || return
    git checkout $(awk '{print $2}' <<<"$target")
}

