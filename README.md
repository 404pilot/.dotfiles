
dotfiles
========

1. `iTerm2`
   * load preferences

2. install `homebrew`

   `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

3. `brew install git jenv bash-completion ccat rbenv`

4. install `shuttle`, `karabiner`, `hammerspoon`

5. run script to install **config** for

   * `bash`
   * `editorConfig`
   * `git`
   * `hammerspoon`
   * `karabiner`
   * `shuttle`
   * `tmux`
   * other configurations included in bash_bridge file
     * `bash-completion`
     * `jenv`

6. install `atom`

   Sync settings by using `https://github.com/atom-community/sync-settings`

## hammerspoon

```
# list all running applications
for key,value in pairs(hs.application.runningApplications()) do print(key,value) end
```

## Git
	# for office laptop
	git config --global user.name "xx"
	git config --global user.email "me@here.com"

## iTerm2

`General` -> `Preferences`

Check `Load preferences from a custom folder or URL:`

Manually type `~/.dotfiles/iTerm2`

## Jenv
```
brew install jenv
echo 'eval "$(jenv init -)"' >> ~/.bashrc

# not need to do the following, since brew install jenv under /usr/local/bin
# echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
```
```
# java8
brew cask install java
# add java8 to jenv
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/
# configure
jenv global 1.8
```

### enable jenv for maven
```
# run maven with a specific jdk
jenv local 1.7
jenv enable-plugin maven

# double-check to see which java version maven is using
mvn -version

# list all JAVA_HOMEs
ls -alF ~/.jenv/versions
```

### java locations

* brew install location: `/Library/Java/JavaVirtualMachines/`
  * `/usr/bin/java` -> `/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java` -> one of `/Library/Java/JavaVirtualMachines/`
* system default location: `/System/Library/Frameworks/JavaVM.framework/Versions/`
* java in System Perferences location: `/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/`



## rbenv

```
rbenv versions
rbenv global 2.2.3
# shell has be specified for each new session, otherwise it will use a default one
rbenv shell 2.2.3
```

## Homebrew

### usages
[FAQ](http://docs.brew.sh/FAQ.html)

```
# update homebrew itself
brew update

# upgrade everything
brew upgrade

# version
brew outdated
brew pin activemq
brew unpin activemq
brew list --pinned

# cleanup & uninstall
brew cleanup git
brew uninstall git
brew uninstall --force git
## list what would be cleaned up
brew cleanup -n
brew cleanup

# figure out who is using a specific formula
brew uses --installed stranger_formula

# list all dependencies
brew deps --installed
```

### details

1. homebrew install apps @ `/usr/local/Cellar/`
2. create corresponding link @ `/usr/local/bin/`

Thus, homebrew will  set `/etc/paths` to

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

## Homebrew Cask

applications are installed at `/usr/local/Caskroom`, each application could have multiple versions

```
# find out outdated installed versions
brew cask outdated
```

Probably need to manually delete old versions.

### brew cask install java

[https://github.com/caskroom/homebrew-cask/blob/master/Casks/java.rb](https://github.com/caskroom/homebrew-cask/blob/master/Casks/java.rb)

it will create links under `/Library/Java/JavaVirtualMachines/`.

```
$ ls -alF ~/.jenv/versions
total 48
drwxr-xr-x   8 T800  staff  272 Jul 24  2015 ./
drwxr-xr-x  12 T800  staff  408 Jul 24  2015 ../
lrwxr-xr-x   1 T800  staff   63 Jul 23  2015 1.7@ -> /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home
lrwxr-xr-x   1 T800  staff   63 Jul 23  2015 1.7.0.45@ -> /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home
lrwxr-xr-x   1 T800  staff   63 Jul 24  2015 1.8@ -> /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home
lrwxr-xr-x   1 T800  staff   63 Jul 24  2015 1.8.0.45@ -> /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home
lrwxr-xr-x   1 T800  staff   63 Jul 23  2015 oracle64-1.7.0.45@ -> /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home
lrwxr-xr-x   1 T800  staff   63 Jul 24  2015 oracle64-1.8.0.45@ -> /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home
```
