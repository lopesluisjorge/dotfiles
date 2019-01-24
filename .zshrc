# Binaries
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
# ZSH_THEME="robbyrussell"
ZSH_THEME="avit"

# Case Sensitive
CASE_SENSITIVE="true"

# Auto update
export UPDATE_ZSH_DAYS=13

plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration

# Go
# export PATH="$HOME/go/bin:$PATH"
# export GOPATH="$HOME/go"

# PHP
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Bash
export PATH="$HOME/.bin/:$PATH"

# Python
alias pip="pip3"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
