#!/bin/bash
set -e
set -u

# For slow-loading Cygwin problems (traced to loading the Bash_completion
# script):
# 
# from the discussion on StackOverflow.com:
# The longer solution is to work through the files in /etc/bash_completion.d
# and disable the ones you don't need. 
# If you rename a file in /etc/bash_completion.d to have a .bak extension,
# it'll stop that script being loaded. 

# This should rename unused bash-complete files to an ignored form
#
# A list of activated and deactivated files is created in the working
# directory. 
# Future improvements (time and effort permitting): 
# * make unactive files re-activated automatically when running program
# * redirect output files to user-specified path
# * scan for exceptions and implement appropriate actions
# * output a log file

###This is supposed to capture the filename and extension separately. In
###conjuction with a routine to grab all the files in the folder, modifying each
###
###file as appropriate should be straightforward.
###filename=$(basename "$fullfile")
###extension="${filename##*.}"
###filename="${filename%.*}"


BASHLIST="bashed.txt"
ACTIVATEDLIST="active.txt"
DEACTIVATEDLIST="notActive.txt"
COMPLETIONDIR="/etc/bash_completion.d" # location of bash-completion files

EXCEPTIONS=(configure bash-builtins)

# get a list of all files in bash-completion.d
ls -1 /etc/bash_completion.d > $BASHLIST

for k in $ACTIVATEDLIST $DEACTIVATEDLIST ; do

if [ -w $k ]; then
	echo "" > $k
	echo "$k cleared"
else
	touch $k
	echo "$k made"
fi
done

#cp bash_complete_files.txt $BASHLIST

NUM=0;

for i in $(grep $ $BASHLIST); do
	echo -ne "." # print progress bar

#	if (	type $i 1>/dev/null 2>&1 || ! echo "$i not installed"); then # check if
#	program exists
	if type $i 1>/dev/null 2>&1 ; then # increase count if existant let
		NUM=$NUM+1
		echo $i >> "$ACTIVATEDLIST"
#	elif ( for j in ${#EXCEPTIONS[*]}; do ${EXCEPTIONS[$j]} = $i; done ); # check
#	nht in exceptions list
#
#		let NUM=$NUM+1 echo $i >> $ACTIVATEDLIST
	else  # not used - rename to .bak
#		echo "$i not installed"
		echo $i>> "$DEACTIVATEDLIST" 
		mv $COMPLETIONDIR/$i $COMPLETIONDIR/$i.bak 
	fi
done

echo ""
echo "`wc -w $BASHLIST |grep "[0-9]"` files total."
echo "$NUM files activated, `wc -w $DEACTIVATEDLIST` files deactivated. "
echo "List of active files can be found in "`readlink -f $ACTIVATEDLIST`" ."
echo "Deactivated files can be found in "`readlink -f $DEACTIVATEDLIST`" ."

# remove created files
rm -f $BASHLIST;
