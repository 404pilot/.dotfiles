# homebrew install zsh
source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# antigen bundle git
antigen bundle autojump # have to run `brew install autojump` first
antigen bundle extract

## personal config needs to be put at the beginning otherwise :faceplam
# zstyle :omz:plugins:ssh-agent identities id_rsa_personal id_rsa
# antigen bundle ssh-agent

# antigen bundle vi-mode
# antigen bundle dotenv

## disable ones that are not currently used
# antigen bundle darvid/zsh-poetry
antigen bundle pipenv
antigen bundle jenv
antigen bundle pyenv
antigen bundle sdk
antigen bundle nvm
# antigen bundle aws
# antigen bundle gradle
# antigen bundle docker
# antigen bundle docker-compose

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-docker

# Load the theme.
antigen theme robbyrussell

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
