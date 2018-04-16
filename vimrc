set history=200

if (&term == "rxvt-unicode-256color") && (&termencoding == "")
	set termencoding=utf-8
endif

"filetype indent plugin on

if &t_Co > 2 || has("gui_running")
	syntax enable
	highlight Normal guibg=Black guifg=White

	au BufNewFile,BufRead *Pkgfile set filetype=sh
	au BufNewFile,BufRead *shlib set filetype=sh
	au BufNewFile,BufRead *bmod set filetype=sh
	set background=dark
	colorscheme inkpot
endif

if has("gui_running")
	:set guifont=Monospace\ 12
endif

set nocompatible
set nobackup

set ai
set si

set pastetoggle=<F2>

set spell
set spelllang=en_us
set backspace=indent,eol,start

set tabstop=2 softtabstop=0 shiftwidth=2 smarttab expandtab
