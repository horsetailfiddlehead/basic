echo "sourcing profile..."
if [ `uname -o` = "Cygwin" ]; then
	echo "for Cygwin build"
	source $HOME/.bashrc
elif [ `uname -o` = "GNU/Linux" ]; then
	echo "for Linux build"
	source $HOME/.bashrc
else
	echo "for other build"
	source $HOME/.bashrc
fi
