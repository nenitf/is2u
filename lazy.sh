#!/usr/bin/env bash
sudo apt-get install -y git
cd ~
mkdir -p dev
cd dev
git clone https://github.com/nenitf/mei4d2u.git
cd mei4d2u
chmod +x install.sh
./install.sh
