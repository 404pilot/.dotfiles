# ref: https://github.com/zsh-users/antigen
source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

# ---------------------------------------------------------------------------
# oh-my-zsh base library
# ---------------------------------------------------------------------------
antigen use oh-my-zsh

# ---------------------------------------------------------------------------
# core shell
# ---------------------------------------------------------------------------
antigen bundle autojump    # needs: brew install autojump
antigen bundle extract     # universal archive extraction

zstyle :omz:plugins:ssh-agent identities id_rsa_personal
antigen bundle ssh-agent

# ---------------------------------------------------------------------------
# vi mode
# ref: https://github.com/jeffreytse/zsh-vi-mode
# note: configured in app_configs (zvm_config / zvm_after_init)
# ---------------------------------------------------------------------------
antigen bundle jeffreytse/zsh-vi-mode

# ---------------------------------------------------------------------------
# python
# ---------------------------------------------------------------------------
antigen bundle pyenv
antigen bundle pipenv
antigen bundle darvid/zsh-poetry

# ---------------------------------------------------------------------------
# ruby
# ---------------------------------------------------------------------------
antigen bundle rbenv

# ---------------------------------------------------------------------------
# javascript
# ---------------------------------------------------------------------------
antigen bundle nvm
antigen bundle npm
antigen bundle node

# ---------------------------------------------------------------------------
# infrastructure
# ---------------------------------------------------------------------------
antigen bundle terraform
# antigen bundle aws
# antigen bundle docker
# antigen bundle docker-compose

# ---------------------------------------------------------------------------
# shell enhancements
# ---------------------------------------------------------------------------
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# ---------------------------------------------------------------------------
# theme — spaceship prompt
# ref: https://github.com/spaceship-prompt/spaceship-prompt
# configured in app_configs
# ---------------------------------------------------------------------------
antigen theme denysdovhan/spaceship-prompt

# ---------------------------------------------------------------------------
# oh-my-zsh settings (must be set before antigen apply)
# ---------------------------------------------------------------------------
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

echo "[antigen] applying plugins..."
antigen apply
