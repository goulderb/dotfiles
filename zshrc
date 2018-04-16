export ZSH=/Users/brettgoulder/.oh-my-zsh
ZSH_THEME="fishy"

#CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
#DISABLE_AUTO_UPDATE="true"
#export UPDATE_ZSH_DAYS=13

# DISABLE_LS_COLORS="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git,
  osx,
  docker-compose,
  ssh-agent
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
