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

function php74 {
	docker run \
		-it \
		--rm \
		--volume $PWD:/app \
		--workdir /app \
		--user $(id -u):$(id -g) \
		php-xdebug php $@
}

function composer {
	docker run \
		-it \
		--rm \
		--volume $(pwd):/app \
		--volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp \
		--workdir /app \
		--user $(id -u):$(id -g) \
		composer:latest $@
}
