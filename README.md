dotfiles
========


## Bash

	echo "source ~/.bash_aliases" >> ~/.bashrc
	
	# under dotfiles_folder
	ln -s .dotfiles/bash/bash_aliases ~/.bash_aliases
	
	source ~/.bashrc
	
## Git

	rm ~/.gitconfig
	
	ln -s .dotfiles/git/gitconfig ~/.gitconfig
	
	# for office laptop
	git config --global user.name "xx"
	git config --global user.email "me@here.com"