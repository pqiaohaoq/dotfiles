#!/usr/bin/env zsh

[[ $- != *i* ]] && return

[[ -n "$TERM_PROGRAM" ]] && export TERM=xterm-256color


bindkey -v
setopt NO_BEEP
setopt PROMPT_SUBST

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY


function fh() {
    local selected
    selected=$(fc -li 1 | sed -E 's/^[[:space:]]*[0-9]+\*?[[:space:]]+//' | fzf +s --tac --height "50%" | sed -E 's/^[^ ]* [^ ]* [[:space:]]*//') || return
    BUFFER="$selected"
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N fh
bindkey '^R' fh


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

export GPG_TTY=$(tty)


function add_path() {
    export PATH=${PATH}:$1
}
add_path "${GOPATH}/bin"
add_path "${HOME}/.local/bin"
add_path "${HOME}/.node_modules/bin"
add_path "/usr/local/bin" # for homebrew bin

source /usr/share/nvm/init-nvm.sh

function fco() {
    local branches target target_type remote_branch local_branches remote_branches tags

    local_branches=$(git --no-pager branch --format="%(refname:short)")
    remote_branches=$(git --no-pager branch -r --format="%(refname:short)" | sed 's#^[^/]*/##')
    tags=$(git --no-pager tag --format="%(refname:short)")

    branches=$(
        {
        comm -12 <(echo "$local_branches" | sort) <(echo "$remote_branches" | sort) 2>/dev/null | awk '{printf "branch\t\033[32m both \033[m\t%s\n", $0}'
        comm -23 <(echo "$local_branches" | sort) <(echo "$remote_branches" | sort) 2>/dev/null | awk '{printf "branch\t\033[36m local\033[m\t%s\n", $0}'
        comm -13 <(echo "$local_branches" | sort) <(echo "$remote_branches" | sort) 2>/dev/null | awk '{printf "branch\t\033[35mremote\033[m\t%s\n", $0}'
        echo "$tags" | awk 'NF {printf "tag\t\033[33m tag  \033[m\t%s\n", $0}'
        }
    ) || return

    target=$(echo "$branches" | fzf --no-hscroll --no-multi --ansi --delimiter='\t' --with-nth=2..) || return
    target_type=$(echo "$target" | awk -F'\t' '{print $1}')
    target=$(echo "$target" | awk -F'\t' '{print $3}')

    case "$target_type" in
        tag)
            git checkout "refs/tags/$target"
            ;;
        branch)
            if git show-ref --verify --quiet "refs/heads/$target"; then
                git checkout "$target"
            else
                remote_branch=$(git branch -r --format="%(refname:short)" | { grep "/${target}$" || true; } | head -1)
                if [[ -n "$remote_branch" ]]; then
                    git checkout -b "$target" "$remote_branch"
                else
                    git checkout -b "$target"
                fi
            fi
            ;;
        *)
            return 1
            ;;
    esac
}

