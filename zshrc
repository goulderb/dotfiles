if [ -f /etc/gentoo-release -o -f /etc/debian_version ]; then
	source /etc/zsh/zprofile
	[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
	[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history

	[[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
	[[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
else
	source /etc/profile
fi

if type -p dircolors >/dev/null ; then
	eval `dircolors -b`
fi

# Set terminal window title
precmd () {
	[[ -t 1 ]] || return
	case $TERM in    
		*xterm*|rxvt|rxvt-unicode*|(dt|k|E|a)term)
			print -Pn "\e]2; %n:%~ - $TERM \a"
			;;
		screen*)
			print -Pn "\e\"[ %n:%~ - $TERM ]\e\134"
			;;
	esac
}

[[ -t 1 ]] || return
case $TERM in
	*xterm*|rxvt|rxvt-unicode*|(dt|k|E|a)term)
		preexec () {
			print -Pn "\e]2; $1 - $TERM \a"
		}
		;;
	screen*)
		preexec () {
			print -Pn "\e\"$1\e\134"
		}
		;;
esac

ulimit -Sc 0
ulimit -Hc 0

if `which keychain &>/dev/null`; then
	`keychain --eval &>/dev/null`
fi

# Prompt
PROMPT="%n@%m\$ "
RPROMPT=$'%.%'

# Exports
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
export HOSTTYPE="$(uname -m)"
export LESS="-R"
export PAGER="less"
export EDITOR=vim
export CVS_RSH=ssh
export RSYNC_RSH=ssh
export GIT_AUTHOR_NAME="Brett Goulder"
export GIT_AUTHOR_EMAIL="goulderba@gmail.com"
export GIT_COMMITTER_EMAIL="goulderba@gmail.com"
export GIT_COMMITTER_NAME="Brett Goulder"
export GOPATH="$HOME/go"
export PATH="/usr/local/bin:$PATH:~/.rvm/bin:$GOPATH/bin:$(go env GOROOT)/bin"

# Primary (read "library") functions, used in functions below.
die() {
	echo "ERROR: $@"
	exit 1
}

# Completion
autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache 1
compctl -f -x 'S[1][2][3][4][5][6][7][8][9]' -k '(1 2 3 4 5 6 7 8 9)' \
	- 'R[[1-9nlo]|[1-9](|[a-z]),^*]' -K 'match-man' \
	- 's[-M],c[-1,-M]' -g '*(-/)' \
	- 's[-P],c[-1,-P]' -c \
	- 's[-S],s[-1,-S]' -k '( )' \
	- 's[-]' -k '(a d f h k t M P)' \
	- 'p[1,-1]' -c + -K 'match-man' \
	-- man

# Aliases
alias ls="gls -CFX --color=auto --group-directories-first"
alias dir="gls -CFX --color=auto --group-directories-first"
alias rm="grm -Iv"
alias rmd="grm -RIv"
alias rejclean="find -name '*.orig' -exec rm -v '{}' ';'; find -name '*.rej' -exec rm -v '{}' ';'; find -name '*~' -exec rm -v '{}' ';'" 
alias vim="vim -p"
alias cp="cp -i"
alias mv="mv -i"
alias ln="ln -i"
alias trash="trash -v"
alias chown="gchown --preserve-root"
alias chmod="gchmod --preserve-root"
alias chgrp="gchgrp --preserve-root"

# Key bindings
case $TERM in (xterm*|aterm|rxvt|rxvt-unicode*)
	bindkey "\e[1~" beginning-of-line # Home
	bindkey "\e[4~" end-of-line # End
	bindkey "\e[5~" beginning-of-history # PageUp
	bindkey "\e[6~" end-of-history # PageDown
	bindkey "\e[2~" quoted-insert # Ins
	bindkey "\e[3~" delete-char # Del
	bindkey "\e[5C" forward-word
	bindkey "\eOc" emacs-forward-word
	bindkey "\e[5D" backward-word
	bindkey "\eOd" emacs-backward-word
	bindkey "\e\e[C" forward-word
	bindkey "\e\e[D" backward-word
	bindkey "\e[Z" reverse-menu-complete # Shift+Tab
	bindkey "\e[7~" beginning-of-line # Home
	bindkey "\e[8~" end-of-line # End
	bindkey "\eOH" beginning-of-line
	bindkey "\eOF" end-of-line
	bindkey "\e[H" beginning-of-line
	bindkey "\e[F" end-of-line
esac
