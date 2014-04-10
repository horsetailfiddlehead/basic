# Author: Patrick Ma
# 2/17/2014
#
# Makefile to automatically move the appropriate sourcing files
# from basic to where they need to go so programs source them properly
#

TEMP_FILES=*.*~ *.~*

all: vim bash gitignore gitconfig
	
vim:
	@echo 'creating .vimrc'
	@echo 'source ~/basic/.vimrc' > ~/.vimrc

test:
	touch foo.txt
	ln -s foo.txt ~/

bash:
	@echo 'creating .bashrc'
	@echo 'source ~/basic/.bashrc' > ~/.bashrc

# Actually creates a global ignore file, not the specific gitignore file
gitignore:
	@echo 'creating globalignore file'
	@cp ./.gitignore_global ~

gitconfig:
	@echo 'creating gitconfig file'
	@cp ./.gitconfig ~

notemps:
	@echo 'removing temporary files'
	@rm -f $(TEMP_FILES)
	@echo 'done'

clean:
	@rm -fv ~/.gitconfig ~/.gitignore_global ~/.bashrc ~/.vimrc 
