#!/bin/zsh

docker run \
    --interactive \
    --rm \
    --network host \
    --volume "$HOME":"$HOME":ro \
    --user $(id -u):$(id -g) \
    --workdir "$PWD" \
    php:7.4-cli-alpine \
    php "$@"

return $?
