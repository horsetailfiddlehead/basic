# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Bash completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# PATH also searches current directory
PATH=$PATH:~/links:/proc/registry:.

# open up Bash at my home directory
#cd ~

#----------Start up options -------------
WELCOME=FALSE  #show welcome splash? (must be false for scp or sftp)
MESSAGE_ME=FALSE  #allow others to message?
export HISTCONTROL=erasedups

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
alias windows="startxwin" # start up Xserver windows
alias endxwin="echo 'this command has not been defined'"
alias whereami='echo You are here: `pwd`'
alias grepc="grep --color=auto"
alias startxwin='startxwin -fg white -bg black'

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

PS1="\n\[\e[32m\]\u@\h: \[\e[33m\]\w$(parse_git_branch)\[\e[0m\]\n`date`\n$ "

#use the terminal colours set in DIR_COLORS
eval "`dircolors -b /etc/DIR_COLORS.256color`"

#------ DISPLAY WELCOME SCREEN -----
if [ $WELCOME = TRUE ]; then
    echo "Hello, `grep $USER /etc/passwd | cut -d: -f5`($USER)!"
    echo "The current time is `date "+%I:%M %p, %A %B %d, %Y"`."
    echo "Logged onto: $HOSTNAME."
    echo "Chat enabled: `mesg`"
fi
