# User specific aliases and functions

alias lstoday="echo ----- Local files modified today -----; find . -maxdepth 1  -daystart -mtime -1 -exec ls -latphd '{}' \;"
alias b="emacs ~/.bashrc"
alias ref="clear; source ~/.bashrc"
alias e="emacs -nw"
alias ff="firefox &"
alias l="ls"
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"
alias home="cd ~"
alias foo="clear"

# LOL!!1
alias wtf='dmesg'
alias onoz='cat /var/log/errors.log'
alias rtfm='man'

alias visible='echo'
alias invisible='cat'
alias moar='more'

alias icanhas='mkdir'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'

alias hai='cd'
alias plz='pwd'

alias inur='locate'

alias nomz='ps -aux'
alias nomnom='killall'

alias cya='reboot'
alias kthxbai='halt'

#The lovely PATH
export PATH=$PATH:~/Documents/scripts

# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

export LD_LIBRARY_PATH=/usr/lib

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1="\n\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]o_O\[\e[0m\]; fi\`\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w\n\[\033[1;31m\]\[\033[31m\]\u\[\033[m\]@\[\033[36m\]\h:\[\033[0m\]-> \[\033[0m\]"
	else
		PS1="\n\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]o_O\[\e[0m\]; fi\`\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w\n\[\033[1;31m\]\[\033[32m\]\u\[\033[m\]@\[\033[36m\]\h:\[\033[0m\]-> \[\033[0m\]"
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhssu
