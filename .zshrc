# Binaries
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

# Auto update
export UPDATE_ZSH_DAYS=13

plugins=()

source $ZSH/oh-my-zsh.sh

# config
export LANG=en_US.UTF-8
export EDITOR='vim'

# php
export PATH="$HOME/.composer/vendor/bin:$PATH"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# aliases

# vim
alias vim="nvim"
alias vimconfig="vim ~/.config/nvim/init.vim"

# zsh
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# python
alias pip="pip3"
venv_activate() {
  source $PWD/venv/bin/activate
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
