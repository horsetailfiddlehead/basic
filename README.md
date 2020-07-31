Author: Patrick Ma
February 14, 2014

Repo: basic.git

This repo is reserved for basic setup and configuration files that I may want accessible from remote locations.

IMPORTANT: many configuration files are probabaly hidden, so if you can't find it, try enabling any options to view hidden files.

Setup of the repo:
1) Download this repo from Dropbox or Github.
1a) to clone from github: https://github.com/horsetailfiddlehead/basic
2) Create a new file with the proper name (i.e.: .bashrc, .gitignore, etc.)
3) Link the file to the file in this repo (do not move the file, or it will not
		update properly). A symbolic link is preferred for compatibility across
		systems/drives.
4) Alternately, instruct the file to source the associated file in this repo.

GitK configuration: copy or link `gitk_config` to `~/.config/git/gitk` _or_ `%HOMEPATH%\.gitk`

TODO: Here's things I want to add and modify in this file
* put the rest of my config files in
* create a make file or script that automatically moves config files to the home directory (or where ever the config file is sourced from).
* create a python version of the make file, as Make is not natively packaged with gitBash
