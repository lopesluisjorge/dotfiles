#!/bin/bash

mkdir $HOME/.opt
sudo dnf update -y

# rpm-fusion
sudo dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-29.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-29
sudo dnf install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-29.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-29

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

# firefox
sudo dnf install -y firefox

# libreoffice
sudo dnf install -y libreoffice

# devtools
sudo dnf groupinstall -y 'Development Tools'

# java
sudo dnf install -y \
	java-openjdk-devel \
	java-openjdk-src

# terminator
sudo dnf install -y terminator

# vim
sudo dnf install -y neovim

# git
sudo dnf install -y git

# copy and paste
sudo dnf install -y \
	xselx \
	clip

# sensors
sudo dnf install -y lm_sensors

# httpie
sudo dnf install -y httpie

# htop
sudo dnf install -y htop

# iotop
sudo dnf install -y iotop

# dia
sudo dnf install -y dia

# gparted
sudo dnf install -y gparted

# code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# subl
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text

# dbeaver
curl https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz -o dbeaver.tar.gz
tar xvf dbeaver.tar.gz -C $HOME/.opt/dbeaver

# eclipse
curl https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2019-09/R/eclipse-java-2019-09-R-linux-gtk-x86_64.tar.gz -o eclipse.tar.gz
tar xvf eclipse.tar.gz -C $HOME/.opt/eclipse

# sts4
curl https://download.springsource.com/release/STS4/4.4.1.RELEASE/dist/e4.13/spring-tool-suite-4-4.4.1.RELEASE-e4.13.0-linux.gtk.x86_64.tar.gz -o sts4.tar.gz
tar xvf sts4.tar.gz -C $HOME/.opt/sts4

# postman
curl https://dl.pstmn.io/download/latest/linux64 -o postman.tar.gz
tar xvf postman.tar.gz -C $HOME/.opt/postman

# docker
curl https://download.docker.com/linux/static/stable/x86_64/docker-18.09.9.tgz -o docker.tar.gz
tar xzvf docker.tar.gz
sudo cp docker/* /usr/bin/
sudo groupadd docker
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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
