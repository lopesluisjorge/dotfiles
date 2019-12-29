#!/bin/bash

export PGSQL_CONTAINER_NAME=pgsql_12_global
export PGSQL_VOLUME_NAME=pgsql_12_global_volume
export REDIS_CONTAINER_NAME=redis_5_global
export MYSQL_CONTAINER_NAME=mysql_57_global
export MYSQL_VOLUME_NAME=mysql_57_global_volume

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
		$MYSQL_CONTAINER_NAME mysql $@
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
		php:7.4-cli-alpine $@
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
		composer:latest composer $@
}

export PATH
