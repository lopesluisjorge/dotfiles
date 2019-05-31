#!/bin/bash

sudo dnf -y update

su -c 'dnf install deltarpm && echo "deltarpm=1" >> /etc/dnf/dnf.conf'
