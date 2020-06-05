# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# user specific environment
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# bash initialization
. $HOME/.init_my_bash.sh

# create opt folder
if [ `ls -alh $HOME | grep -i " .opt$" | wc -l` -eq 0 ]; then
	mkdir $HOME/.opt
fi

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

. $HOME/.my_custom_bash.sh

export PATH=$HOME/.composer/vendor/bin:$PATH # composer
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" # yarn

alias php74="docker run -it --rm  -v $PWD:/app -w /app --user 1000:1000 php:7.4-alpine php $@" # php
