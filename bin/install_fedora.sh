#!/bin/bash

# update
sudo dnf update -y

# rpm-fusion
sudo dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-29.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-29
sudo dnf install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-29.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-29

# multimedia

# pragha
sudo dnf install -y pragha

# smplayer
sudo dnf install -y smplayer

# gpicview
sudo dnf install -y gpicview

# gimp
sudo dnf install -y gimp

# mesa
sudo dnf install -y \
	mesa-dri-drivers.i686 \
	mesa-libGL.i686 \
	xorg-x11-drv-intel

# pdf
sudo dnf install -y evince

# tar
sudo dnf install -y \
	p7zip \
	p7zip-plugins \
	lzip \
	cabextract \
	unrar

# youtube-dl
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# browsers

# firefox
sudo dnf install -y firefox

# google-chrome
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
sudo tee /etc/yum.repos.d/google-chrome.repo <<RPMREPO
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
RPMREPO

sudo dnf install -y google-chrome-stable

# office

# libreoffice
sudo dnf install -y libreoffice

# langs

# devtools
sudo dnf groupinstall -y 'Development Tools'

# java
sudo dnf install -y \
	java-openjdk-devel \
	java-openjdk-src

# php
sudo dnf install -y \
	php-cli \
	php-zip \
	php-gd \
	php-pgsql \
	php-json \
	php-xml \
	php-mbstring \
	php-mcrypt \
	php-intl

# composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
source ./global-req-php

# node
sudo curl -sL https://rpm.nodesource.com/setup_12.x | bash -
./npminstalls

# tools

# vim
sudo dnf install -y neovim

# git
sudo dnf install -y git

# copy/paste
sudo dnf install -y \
	xselx \
	clip

# sensors
sudo dnf install -y lm_sensors

# ab
sudo dnf install -y httpd-tools

# httpie
sudo dnf install -y httpie

# htop
sudo dnf install -y htop
sudo dnf install -y iotop

# ntp
sudo dnf install -y ntp

# dia
sudo dnf install -y dia

# clear hd
sudo dnf install -y bleachbit

# gparted
sudo dnf install -y gparted

# zsh
sudo dnf install -y zsh

# ag
sudo dnf install -y ag

# python
pip install --user pylama esptool

# editors

# code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
source ./pulldockerimages

# config ntp
sudo timedatectl set-ntp true

# zram
sudo dnf install -y zram
sudo zramstart
sudo systemctl enable zram-swap.service

# oh-my-zsh
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
