#!/usr/bin/env bash
sudo apt-get install -y git
cd ~
mkdir -p dev
cd dev
git clone https://github.com/nenitf/is2u.git is
cd is
chmod +x install.sh
./install.sh
