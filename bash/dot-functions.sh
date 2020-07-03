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
