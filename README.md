dotfiles
========

## How to use it

1. Install `homebrew`

2. Configure a personal ssh key and upload it to github
   
   ```shell
   # the location will be ~/.ssh/id_rsa_personal
   $ ssh-keygen -C "xxx+personal@gmail.com"
   
   # verify it uses the right user
   $ ssh -i ~/.ssh/id_rsa_peronsal -T git@github.com
   ```

3. Install `dotfiles`
   
   ```shell
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/404pilot/.dotfiles/master/up.sh)" -s -a install_apps -f install_fonts -m update_mac_defaults
   ```

4. Manually install apps
   
   - karabiner
   
   - hammerspoon
   
   - iterm2
   
   - shuttle

5. Configure ssh keys for work at `~/.ssh/id_rsa_work`

### Other Applications

```
# dev
docker
postman
iHosts

# Essential
notion
clipy
typora
hapticKey https://github.com/niw/HapticKey/issues

# Misc
amphetamine
hidden bar
pomo timer
Irvue
Itsycal
numi
clocker
noizio
imageOptim
Lightweight PDF

# in case, disk storage is not enough
omniDIskSweeper
tencent lemon lite
```
