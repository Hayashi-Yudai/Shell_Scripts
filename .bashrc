case $- in
    *i*) ;;
      *) return;;
esac

# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      color_prompt=yes
    else
      color_prompt=
    fi
fi

unset color_prompt force_color_prompt


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export LANG=en_US

PATH=/bin:/sbin:/usr/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:/snap/bin:/usr/games:/usr/local/games
# PATH=$PATH:/opt/vim/src
GOPATH=$HOME/go/src
PATH=$PATH:$GOPATH/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/lib/google-cloud-sdk/bin
PATH=$PATH:/home/yudai/Android/Sdk/platform-tools/
PATH=$PATH:/usr/local/cuda-11.4/bin
PATH=$PATH:/home/yudai/.deno/bin
PATH=$PATH:$HOME/.poetry/env
export GO111MODULE=on
export CUDA_PATH=/usr/local/cuda
export CFLAGS=-I$CUDA_PATH/include/
export PATH=$PATH:/usr/local/cuda/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.4/lib64
export CUDA_HOME=/usr/local/cuda
export ENVIRONMENT=local


PYENV_ROOT=$PATH:$HOME/.pyenv
PATH=$PATH:$PYENV_ROOT/bin:$PATH
eval "$(pyenv init --path)"
eval "$(fasd --init auto)"

export PIPENV_VENV_IN_PROJECT=1

export PS1='\[\033[01;34m\]\w\[\033[00m\]\$\n'
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.luaenv/bin:$HOME/.luaenv/shims:$PATH"
eval "$(luaenv init -)"

eval "$(starship init bash)"
. "$HOME/.cargo/env"

PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
  (grep -o '[a-f0-9]\{7\}' | head -1 |
  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
  {}
FZF-EOF"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fvir() {
  local file
  file=$(rg $1 | fzf | cut -d ":" -f 1)
  vim $file
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/yudai/google-cloud-sdk/path.bash.inc' ]; then . '/home/yudai/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/yudai/google-cloud-sdk/completion.bash.inc' ]; then . '/home/yudai/google-cloud-sdk/completion.bash.inc'; fi
