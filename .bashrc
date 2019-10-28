# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

l() {
	ls -alh $@
}

vim() {
	nvim $@
}

startpgsql() {
	docker run \
		--detach \
		--name postgresglobal \
		--volume $PWD:/app \
		--volume postgresglobal:/var/lib/postgresql/data \
		--publish 5432:5432 \
		--env POSTGRES_USER=postgres \
		--env POSTGRES_PASSWORD=postgres \
		postgres:12-alpine
}

psql() {
	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		postgresglobal psql -U postgres -W $@
}

startmysql() {
	docker run \
		--detach \
		--name mysqlglobal \
		--volume $PWD:/app \
		--volume mysqlglobal:/var/lib/mysql \
		--publish 3306:3306 \
		--env MYSQL_ROOT_PASSWORD=root \
		mysql:5.7
}

mysql() {
	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		mysqlglobal mysql $@
}

php() {
	docker run \
		--interactive \
		--tty \
		--rm \
		--publish 8000:8000 \
		--publish 8888:8888 \
		--publish 9000:9000 \
		--workdir /app \
		--volume $PWD:/app \
		--user $(id -u):$(id -g) \
		php:7.3-alpine $@
}

COMPOSER_HOME="$HOME/.config/composer"
export COMPOSER_HOME

COMPOSER_CACHE_DIR="$HOME/.cache/composer"
export COMPOSER_CACHE_DIR

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
		composer:latest composer $@
}

export PATH
