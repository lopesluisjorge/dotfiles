# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

if [ `l $HOME | grep -i " .opt$" | wc -l` -eq 0 ]; then
	mkdir $HOME/.opt
fi

export PATH=$HOME/.opt/node/bin:$PATH
export PATH=$HOME/.opt/flutter/bin:$PATH
export PATH=$HOME/.opt/dart-sdk/bin:$PATH
export JAVA_HOME=$HOME/.opt/jdk-11.0.5+10

export M2_HOME=$HOME/.opt/apache-maven-3.6.3
export PATH=$M2_HOME/bin:$PATH

# all containers with name
acwn() {
	docker container ls --all --filter name=$1 --quiet | wc -l
}

# containers with name
cwn() {
	docker container ls --filter name=$1 --quiet | wc -l
}

export PGSQL_CONTAINER_NAME=pgsql12_global
export PGSQL_VOLUME_NAME=pgsql12_global_volume
export REDIS_CONTAINER_NAME=redis5_global
export MYSQL_CONTAINER_NAME=mysql57_global
export MYSQL_VOLUME_NAME=mysql57_global_volume

psql() {
	if [ `cwn $PGSQL_CONTAINER_NAME` -eq 0 ]; then
		docker run \
			--detach \
			--rm \
			--name $PGSQL_CONTAINER_NAME \
			--volume $PWD:/app \
			--volume $PGSQL_VOLUME_NAME:/var/lib/postgresql/data \
			--publish 5432:5432 \
			--env POSTGRES_USER=postgres \
			--env POSTGRES_PASSWORD=postgres \
			postgres:12-alpine
	fi

	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		$PGSQL_CONTAINER_NAME psql -U postgres -W $argv
}

redis-cli() {
	if [ `acwn $REDIS_CONTAINER_NAME` -eq 0 ]; then
		docker run \
			--detach \
			--name $REDIS_CONTAINER_NAME \
			--publish 6379:6379 \
			redis:5-alpine
	fi

	if [ `cwn $REDIS_CONTAINER_NAME` -eq 0 ]; then
		docker start $REDIS_CONTAINER_NAME
	fi

	docker exec \
		--interactive \
		--tty \
		$REDIS_CONTAINER_NAME redis-cli $argv
}

mysql() {
	if [ `cwn $MYSQL_CONTAINER_NAME` -eq 0 ]; then
		docker run \
			--detach \
			--rm \
			--name $MYSQL_CONTAINER_NAME \
			--volume $PWD:/app \
			--volume $MYSQL_VOLUME_NAME:/var/lib/mysql \
			--publish 3306:3306 \
			--env MYSQL_ROOT_PASSWORD=root \
			mysql:5.7
	fi

	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		$MYSQL_CONTAINER_NAME mysql $argv
}

php() {
	docker run \
		--interactive \
		--tty \
		--rm \
		--workdir /app \
		--volume $PWD:/app \
		--user $(id -u):$(id -g) \
		--network host \
		php:7.4-cli-alpine $argv
}

export COMPOSER_HOME="$HOME/.config/composer"
export COMPOSER_CACHE_DIR="$HOME/.cache/composer"

composer() {
	docker run \
		--interactive \
		--tty \
		--rm \
		--workdir /app \
		--volume $PWD:/app \
		--volume $HOME/.composer:/tmp \
		--volume $COMPOSER_HOME:$COMPOSER_HOME \
		--volume $COMPOSER_CACHE_DIR:$COMPOSER_CACHE_DIR \
		--user $(id -u):$(id -g) \
		--network host \
		composer:latest composer $argv
}
