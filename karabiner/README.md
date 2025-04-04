# Karabiner
By default, click 'Misc -> Export & Import -> Open config folder' from karabiner will delete the symbolink file and generate the latest configuration json file which it is a way to configure stuff in GUI first and then get the corresponding configuration file


```
local karabiner_config=~/.config/karabiner/karabiner.json
local dotfiles_config=~/.dotfiles/karabiner/karabiner.json
cp $karabiner_config $dotfiles_config \
    && rm $karabiner_config \
    && ln -s $dotfiles_config $karabiner_config \
    && ls -al $karabiner_config
```
