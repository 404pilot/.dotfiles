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
# must define zvm_config/zvm_after_init BEFORE the bundle loads
# ---------------------------------------------------------------------------
zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT       # start each line in insert mode
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK  # block cursor in normal mode
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM   # beam cursor in insert mode
}

zvm_after_init() {
  _log "fzf"
  eval "$(fzf --zsh)"
}

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
# oh-my-zsh settings (must be set before antigen apply)
# ---------------------------------------------------------------------------
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

_log "antigen"
antigen apply
