#!/bin/bash

sudo dnf update -y

# rpm-fusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-$(rpm -E %fedora)
sudo dnf install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-$(rpm -E %fedora)

# drivers intel
sudo dnf install -y \
	mesa-dri-drivers.i686 \
	mesa-libGL.i686 \
	xorg-x11-drv-intel

# rar, zip
sudo dnf install -y \
	p7zip p7zip-plugins lzip \
	cabextract unrar

# git, terminator, neovim
sudo dnf install -y \
	zsh git neovim \
	terminator

# devtools
sudo dnf groupinstall -y 'Development Tools'

# copy and paste
sudo dnf install -y xselx clip

# htop, iotop, lm_sensors
sudo dnf install -y htop iotop lm_sensors

# ab, httpie
sudo dnf install -y httpd-tool httpie

# gparted
sudo dnf install -y gparted

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

# zram
sudo dnf install -y zram
sudo zramstart
sudo systemctl enable zram-swap.service

# ntp
sudo dnf install -y ntp
sudo timedatectl set-ntp true
