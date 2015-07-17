dotfiles
========

	// put .dotfiles under home folder
	cd && git clone .dotfiles

## Bash

	echo "source ~/.bash_aliases" >> ~/.bashrc
	
	ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
	
	source ~/.bashrc
	
## Git

	rm ~/.gitconfig
	
	ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
	
	# for office laptop
	git config --global user.name "xx"
	git config --global user.email "me@here.com"
	
## iTerm2

`General` -> `Preferences`

Check `Load preferences from a custom folder or URL:`

Manually type `~/.dotfiles/iTerm2`

## Karabiner

	rm ~/Library/Application\ Support/Karabiner/private.xml
	ln -s ~/.dotfiles/Karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

## Sublime Text 3

    ln -s ~/.dotfiles/sublime-text3/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

#### Installed Package

* GitGutter
* JSONLint
* Pretty JSON

## Jenv
	
	# set shell jdk to run maven
	jenv shell openjdk64-1.7.0.79
	
	# list all JAVA_HOMEs
	ls -alF ~/.jenv/versions
	
