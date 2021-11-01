case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PS1='\[\033[01;34m\]\w\[\033[00m\]\$\n'
export LS_COLORS='rs=0:di=00;34:ow=00;34:ln=01;36:mh=00:pi=40;33:so=01;35:bd=40;33:'
LS_COLORS=$LS_COLORS:'*.go=00;36:*.py=00;36:*.rs=00;36:*.c=00;36:*.cpp=00;36:*.cc=00;36'
LS_COLORS=$LS_COLORS:'*.exe=00;35'
LS_COLORS=$LS_COLORS:'*.tar=00;31:*.zip=00;31:*.tgz=00;31:'

PATH="/home/yudai/.pyenv/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
PATH=$PATH:/mnt/c/texlive/2019/bin/win32
PATH=$PATH:/mnt/c/Windows
PATH=$PATH:/opt/vim/src
PATH=$PATH:$HOME/.cargo/bin

PYENV_ROOT=$PATH:$HOME/.pyenv
PATH=$PATH:$PYENV_ROOT/bin:$PATH
PATH=$PATH:$HOME/bin
GOPATH=/home/yudai/go/
PATH=$PATH:$GOPATH/bin/
eval "$(pyenv init --path)"
eval "$(fasd --init auto)"
export PIPENV_VENV_IN_PROJECT=1
export DENO_INSTALL="/home/yudai/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

alias platex='platex.exe --kanji=utf8'
alias latexmk='latexmk.exe'
alias dvipdfmx='dvipdfmx.exe'
function tex () {
  platex $1.tex
  dvipdfmx $1.dvi
}

function winp {
	pwd | sed -e "s;/mnt/c;C:;" -e "s;\/;\\\\\\\\;g" | xargs explorer.exe
}

#source "$HOME/.cargo/env"
. "$HOME/.cargo/env"
