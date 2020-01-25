#!/bin/bash

mkdir $HOME/.opt

sudo dnf update -y

sudo dnf install -y \
	gpicview smplayer evince \
	gimp dia libreoffice

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o $HOME/.local/bin/youtube-dl
chmod a+rx $HOME/.local/bin/youtube-dl

# Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# Sublime Text 3
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text

# Dbeaver
curl https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz -o dbeaver.tar.gz
tar xvf dbeaver.tar.gz -C $HOME/.opt

# Spring Tools 4
https://download.springsource.com/release/STS4/4.5.1.RELEASE/dist/e4.14/spring-tool-suite-4-4.5.1.RELEASE-e4.14.0-linux.gtk.x86_64.tar.gz -o sts4.tar.gz
tar xvf sts4.tar.gz -C $HOME/.opt
