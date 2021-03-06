#!/bin/bash
# Copyright 2018 Tero Karvinen http://TeroKarvinen.com GPL 3

echo "Sirotin Live USB configuration Starting... aksratamo/sirotin"
set -o verbose

echo "Installing Salt and Git..."
sudo apt-get update
sudo apt-get -y install git salt-minion

echo "Retrieving and Applying Settings..."
echo -e "master: localhost\nid: localminion\nfile_client: local" | sudo tee /etc/salt/minion
git clone https://github.com/aksratamo/sirotin.git
cd sirotin/
./highstate.sh

echo "Configuring Live Desktop"
setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple
# git config --global user.email "terosstudent@example.com"
# git config --global user.name "Tero's Student"

echo "More tips on http://terokarvinen.com/tag/saltstack"
echo "Done."
