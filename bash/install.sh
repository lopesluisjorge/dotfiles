#!/bin/bash

# backup :)
cp $HOME/.bashrc $HOME/.bashrc.bkp

cp .bashrc $HOME/.bashrc
cp scripts/envconf.sh $HOME/.envconf.sh
cp scripts/helpers.sh $HOME/.helpers.sh
cp scripts/start.sh $HOME/.start.sh
cp scripts/php-wrapper.sh $HOME/.php-wrapper.sh

source $HOME/.bashrc
