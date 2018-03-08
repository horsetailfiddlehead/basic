# .bashrc

echo "loading settings..."

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Bash completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# Git completion
if [ -f ~/basic/git-prompt.sh ]; then
	. ~/basic/git-prompt.sh
else
	echo "git-prompt.sh not found"
fi
if [ -f ~/basic/git-completion.bash ]; then
	. ~/basic/git-completion.bash
else
	echo "git-completion.sh not found"
fi

# PATH also searches current directory
PATH=$PATH:~/links:/proc/registry:.


#----------Start up options -------------
WELCOME=FALSE  #show welcome splash? (must be false for scp or sftp)
MESSAGE_ME=FALSE  #allow others to message?
export HISTCONTROL=erasedups
export HISTSIZE=50
export HISTIGNORE="pwd:ls:la:lla"

# User specific aliases and functions
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias ls="ls --color=auto"
alias ll="ls -l"
alias lla="ll -a"
alias llp="ll |less"
alias la="ls -a"
alias ?=man
alias grep="grep --color" # highlight search term
alias startxwin='startxwin -fg white -bg black'
alias xterm='xterm -fg white -bg black'
alias windows="startxwin -- -multimonitors" # start up Xserver windows
alias endxwin="echo 'this command has not been defined'"
alias whereami='echo You are here: `pwd`'
alias grepc="grep --color=auto"
alias egrep="egrep --color=auto"
if [ `uname -o` = "Cygwin" ]; then # shortcut to shutdown terminal
	alias shutdown="exit"
elif [ `uname -o` = "GNU/Linux" ]; then 
	alias shutdown="sudo halt" 
fi
alias nmap="/cygdrive/c/Program\ Files\ \(x86\)/Nmap/nmap.exe" # run NMap
arduino() { arduino.exe "$@" > /dev/null 2>&1;} # open arduino w/o console output

# a couple helpful bash options
shopt -s dirspell    # attempts to fix directory misspells
shopt -s cdspell     # attempts to fix cd misspells
shopt -s nocaseglob  # case-insensitive auto-complete 
shopt -s checkwinsize #auto-adjusts COL and LINE to window
shopt -s dotglob     # includes dot-files in glob
export EDITOR=vim

# connect to attu servers
alias attu="ssh attu.cs.washington.edu"
alias dante="ssh dante.u.washington.edu"
alias linuxlab="ssh -X pgma2010@linux$[ 12 + RANDOM % 15 ].ee.washington.edu"

#------- COMMUNICATIONS SETTINGS -----------
# display which people from buddylist.txt are logged on
alias online="w -fh | grep --color=never -wf ~/buddylist.txt| sort"

#allow people to access terminal for chatting, etc.
if [ $MESSAGE_ME = TRUE ]; then
    mesg y
else
    mesg n
fi

#------ DISPLAY SETTINGS ---------
# view what git branch you are on
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\n\[\e[32m\]\u@\h: \[\e[33m\]\w$(__git_ps1)\[\e[0m\]'$'\n`date`\n$ '

#use the terminal colours set in DIR_COLORS
eval "`dircolors -b /etc/DIR_COLORS.256color`"

# set terminal to the right number of colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

#------ DISPLAY WELCOME SCREEN -----
if [ $WELCOME = TRUE ]; then
    echo "Hello, `grep $USER /etc/passwd | cut -d: -f5`($USER)!"
    echo "The current time is `date "+%I:%M %p, %A %B %d, %Y"`."
    echo "Logged onto: $HOSTNAME."
    echo "Chat enabled: `mesg`"
fi

