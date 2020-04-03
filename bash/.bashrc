# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if [ `ls -alh $HOME | grep -i " .opt$" | wc -l` -eq 0 ]; then
	mkdir $HOME/.opt
fi

# added by travis gem
[ -f /home/jorge/.travis/travis.sh ] && source /home/jorge/.travis/travis.sh

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
. $HOME/.asdf/plugins/java/set-java-home.sh

export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias php74="docker container run -it --rm --network host -v $PWD:/app -w /app --user 1000:1000 php:7.4-cli-alpine php"
