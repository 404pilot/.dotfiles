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
     
     - allow notifications under `System Preferences / Notifications / Hammerspoon`
   
   - iterm2
   
   - [shuttle](https://github.com/fitztrev/shuttle)

5. Configure ssh keys for work at `~/.ssh/id_rsa_work`

### Other Applications

* dev
  * docker
  * postman
  * iHosts
* Essential
  * [notion](https://www.notion.so/)
  * [clipy](https://github.com/Clipy/Clipy)
  * typora
  * [Velja](https://sindresorhus.com/velja)
* drive
  * dropbox
  * onedrive
  * google drive
* Misc
  * [amphetamine](https://apps.apple.com/us/app/amphetamine/id937984704?mt=12)
  * [hidden bar](https://apps.apple.com/us/app/hidden-bar/id1452453066?mt=12)
  * [pomo timer](https://apps.apple.com/us/app/pomo-timer/id1447569061?mt=12)
  * [Irvue](https://apps.apple.com/us/app/irvue/id1039633667?mt=12)
  * [Itsycal](https://www.mowglii.com/itsycal/)
  * [numi](https://numi.app/)
  * [clocker](https://apps.apple.com/us/app/clocker/id1056643111?mt=12)
  * noizio
  * [Arc](https://arc.net/)
  * imageOptim
  * Lightweight PDF
* disk storage manager
  * omniDIskSweeper
  * tencent lemon lite
