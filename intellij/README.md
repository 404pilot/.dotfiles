
## Editor tab

#### Show all tabs
`Editor`>`General`>`Editor Tabs` : uncheck `Show tabs in single row`

## Format

`Editor` > `Code Style` > `Java` --> `Wrapping and Braces` > `Keep When Formatting` : uncheck `Comments at first column`

`Editor` > `Code Style` > `Java` --> `Code Generation` > `Comment Code` : uncheck `Line comment at first column`

## keymap

name | keymap
--- | ---
^ w | extend selection
cmd w | close
^ x | close others
^ d | back
^ f | forward
^ t | jump to navigation bar
^ shift x | split vertically
^ q | close active tab
^ u | select in

## Vagrant Integration

intellij cannot find executable under `/usr/local/bin/`

1. install `vagrant` plugin
2. make sure **vagrant executable** under `Tools/Vagrant` is working. (give a full path `/usr/local/bin/vagrant`)
3. run `sudo ln -s /usr/local/bin/VBoxManage /usr/bin/VBoxManage`
