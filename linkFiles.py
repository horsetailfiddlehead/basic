''' A short python script to create symbolic links from the files in the
		git (Dropbox) repo to the $HOME folder
	'''

import subprocess

def makeLink(target="ALL", parentFolder="$HOME"):
	""" Calls the command line and makes a sym link to the target located in the
	parentFolder
	"""
	if parentFolder == "$HOME":
		parentFolder = subprocess.check_output(["echo", "$HOME"])

	if target == "ALL":
		pass # Ideally look at a compiled list of files and where to put them
	else:
		workingDirectory = subprocess.check_output(["pwd"])
		fullTarget = workingDirextory + target
		subprocess.call("ln -s", fullTarget, parentFolder)


