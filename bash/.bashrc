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

export BASH_ENVIRONMENT_CONFIGS="$HOME/.envconf.sh"
export BASH_HELPER_CONFIGS="$HOME/.helpers.sh"
export BASH_DOCKER_CONFIGS="$HOME/.start.sh"

. $BASH_ENVIRONMENT_CONFIGS
. $BASH_HELPER_CONFIGS
. $BASH_DOCKER_CONFIGS
