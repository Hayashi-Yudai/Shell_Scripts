# 大文字・小文字を区別せずに補完
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

eval "$(starship init zsh)"

export PATH="$HOME/.local/bin:$PATH"
export PATH=$HOME/.wantedly/bin:$PATH
export PATH=$HOME/google-cloud-sdk:$PATH
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$HOME/.local/share/mise/shims:$PATH"
export GOPATH=$(go env GOPATH)
export STARSHIP_CONFIG=~/.config/starship.toml

typeset -U PATH  # PATHから重複をなくす

export $(grep -v '^#' ~/.env | xargs)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_alias
source <(kube completion zsh)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

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

fv() {
  local file
  file=$(rg $1 | fzf | cut -d ":" -f 1)
  vim $file
}

# 特定のブランチの最新の完全なコミットハッシュを取得
# 引数省略時にはブランチ関係なく最新のハッシュを返す
lh() {
  git log --first-parent $1 --pretty=oneline -n 1 | awk '{print $1}'
}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yudai/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yudai/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yudai/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yudai/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(fasd --init auto)"



### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
