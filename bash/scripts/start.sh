#!/bin/bash

export PGSQL_CONTAINER_NAME=postgresql12global
export PGSQL_VOLUME_NAME=postgresql12globalvolume
export REDIS_CONTAINER_NAME=redis5global
export MYSQL_CONTAINER_NAME=mysql57global
export MYSQL_VOLUME_NAME=mysql57globalvolume
export COMPOSER_HOME="$HOME/.config/composer"
export COMPOSER_CACHE_DIR="$HOME/.cache/composer"

startdocker() {
	if [ `ps aux | grep "docker" | wc -l` -eq 1 ]; then
		sudo echo "docker\n"
		sudo dockerd &
	fi
}

# all containers with name
acwn() {
	docker container ls --all --filter name=$1 --quiet | wc -l
}

# containers with name
cwn() {
	docker container ls --filter name=$1 --quiet | wc -l
}

psql() {
	if [ `acwn $PGSQL_CONTAINER_NAME` -eq 0 ]; then
		docker run \
			--detach \
			--name $PGSQL_CONTAINER_NAME \
			--volume $PWD:/app \
			--volume $PGSQL_VOLUME_NAME:/var/lib/postgresql/data \
			--publish 5432:5432 \
			--env POSTGRES_USER=postgres \
			--env POSTGRES_PASSWORD=postgres \
			postgres:12-alpine
	fi

	if [ `cwn $PGSQL_CONTAINER_NAME` -eq 0 ]; then
		docker start $PGSQL_CONTAINER_NAME
	fi

	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		$PGSQL_CONTAINER_NAME psql -U postgres -W $@
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
		$REDIS_CONTAINER_NAME redis-cli $@
}

mysql() {
	if [ `acwn $MYSQL_CONTAINER_NAME` -eq 0 ]; then
		docker run \
			--detach \
			--name $MYSQL_CONTAINER_NAME \
			--volume $PWD:/app \
			--volume $MYSQL_VOLUME_NAME:/var/lib/mysql \
			--publish 3306:3306 \
			--env MYSQL_ROOT_PASSWORD=root \
			mysql:5.7
	fi

	if [ `cwn $MYSQL_CONTAINER_NAME` -eq 0 ]; then
		docker start $MYSQL_CONTAINER_NAME
	fi

	docker exec \
		--interactive \
		--tty \
		--workdir /app \
		$MYSQL_CONTAINER_NAME mysql $@
}

php() {
	docker run \
		--interactive \
		--tty \
		--rm \
		--publish 8000:8000 \
		--workdir /app \
		--volume $PWD:/app \
		--user $(id -u):$(id -g) \
		php:7.3-cli-alpine $@
}

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
