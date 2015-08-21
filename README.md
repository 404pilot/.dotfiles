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
```
brew install jenv 
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(jenv init -)"' >> ~/.bashrc
```

#### more
```
# switch "shell jdk" to run maven
jenv enable-plugin maven
jenv shell openjdk64-1.7.0.79
jenv shell 1.8

# double-check to see which java version maven is using
mvn -version

# list all JAVA_HOMEs
ls -alF ~/.jenv/versions
```
	
##### java locations	
	
* brew install location: `/Library/Java/JavaVirtualMachines/`
	* `/usr/bin/java` -> `/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java` -> one of `/Library/Java/JavaVirtualMachines/`
* system default location: `/System/Library/Frameworks/JavaVM.framework/Versions/`
* java in System Perferences location: `/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/`

## Homebrew

```
# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc

brew install tmux git jenv maven tree
```

#### more

1. homebrew install apps @ `/usr/local/Cellar/`
2. create corresponding link @ `/usr/local/bin/`

Thus, set `/etc/paths` to

	/usr/local/bin
	/usr/bin
	/bin
	/usr/sbin
	/sbin

Put `/usr/local/bin` at the first line.

Or go to shell configuration and add `/usr/local/bin` to `$PATH`.

Restart terminal and test it

	$ which git
	/usr/local/bin/git

In this way, I may not need to explicitly specify command home location for `JAVA_HOME` or `MAVEN_HOME` in `.bashrc`. It will automatically use the default one, i,e, the first line in `/etc/paths`.

Use `brew info zsh` to see those dependecies 
