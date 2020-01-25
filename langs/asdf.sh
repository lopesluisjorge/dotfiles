#!/bin/bash

sudo dnf install -y \
	automake autoconf readline-devel \
	ncurses-devel openssl-devel libyaml-devel \
	libxslt-devel libffi-devel libtool unixODBC-devel \
	unzip curl

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6

echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
