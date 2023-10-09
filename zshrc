export ZSH=/Users/brettgoulder/.oh-my-zsh
ZSH_THEME="fishy"

DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  macos
  docker-compose
  ssh-agent
  nvm
  jump
  brew
)

source $ZSH/oh-my-zsh.sh

# User configuration
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
fi

if type -p dircolors >/dev/null ; then
   eval `dircolors -b`
fi

alias rm="grm -Iv"
alias rmd="grm -RIv"
alias cp="cp -i"
alias mv="mv -i"
alias ln="ln -i"
alias ls="gls -CFX --color=auto --group-directories-first"
