##### Shows Current Git Branch for PS1
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# If not running interactively, don't do anything
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
HISTSIZE=2000
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

##### This PS1 has a different color theme and makes the terminal prompt end in a blinking ~⛧ instead of the standard $ symbol
if [ "$color_prompt" = yes ]; then
	PS1="\[\033[34m\]\u@\h \[\033[94m\]\w\[\033[35m\]\$(parse_git_branch)\[\033[5;94m\]~⛧  \[\033[0m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

##### Changes the prompt qwhen using backslashes from the standard > symbol to whatever the PS2 is
PS2=" ✧ > "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# asdf stuff
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

### > > > Fun Aliases > > >

alias train="sl"
alias lc="lolcat"

### > > > Fun Rainbow Commands > > >
# The results of one rainbow command do not automatically pipe into another. Make sure to use the rainbow command last when piping bash commands together.
# Ex.: `history | grepl` "git" will work but `historyl | grep` will not output rainbow colors.
# To make sure that other programs that might use these basic commands don't start doing anything irregular, the names for these where slightly changed.

# Rainbow Commands with Lolcat:

lss(){ echo -e; ls -la | lc; echo -e; }
ll(){ echo -e; ls | lc; echo -e; }
pwdl(){ pwd | lc; echo -e; }
historyl(){ echo -e; history | lc; echo -e; }
grepl(){ echo -e; grep "$1" | lc; echo -e; }
cdl(){ cd "$1"; ll; }
catl(){ echo -e; cat | lc; echo -e; }
taill(){ echo -e; tail | lc; echo -e; }

# Rainbow Commands with rnbw:

rnbw(){ xargs -I % sh -c 'echo " \e[5m % \e[0m"| lolcat '; }

lsd(){ echo -e; ls -la | rnbw; echo -e; }
pwdd(){ echo -e; pwd | rnbw; echo -e; }
historyd(){ echo -e; history | rnbw; echo -e; }
grepd(){ echo -e; grep "$1" | rnbw; echo -e; }
cdd(){ cd "$1"; lld; }
catd(){ echo -e; cat | rnbw; echo -e; }i
taild(){ echo -e; tail | rnbw; echo -e; }
