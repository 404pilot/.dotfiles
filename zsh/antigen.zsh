# from homebrew: https://formulae.brew.sh/formula/antigen
# To activate antigen, add the following to your ~/.zshrc:
#    source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# https://project-awesome.org/unixorn/awesome-zsh-plugins
# antigen bundle git
antigen bundle autojump # have to run `brew install autojump` first
antigen bundle extract

# only add main one; or use AddKeysToAgent in ssh config
zstyle :omz:plugins:ssh-agent identities id_rsa_personal
antigen bundle ssh-agent

# antigen bundle vi-mode
# antigen bundle dotenv

## disable ones that are not currently used

# tag:python
antigen bundle darvid/zsh-poetry
antigen bundle pipenv
antigen bundle pyenv

# tag: java
# antigen bundle jenv
# antigen bundle sdk
# antigen bundle matthieusb/zsh-sdkman

# tag: ruby
antigen bundle rbenv

# tag: javascript
antigen bundle nvm
antigen bundle npm
antigen bundle node

# tools
antigen bundle terraform
# antigen bundle aws
# antigen bundle gradle
# antigen bundle docker
# antigen bundle docker-compose

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-docker

# Load the theme.
# https://github.com/ohmyzsh/ohmyzsh/tree/master/themes
# https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes
# antigen theme robbyrussell
# antigen theme romkatv/powerlevel10k
antigen theme denysdovhan/spaceship-prompt

#################################################################
##################### Custom configurations #####################
#################################################################

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"
#################################################################
#################################################################

# Tell Antigen that you're done.
antigen apply
