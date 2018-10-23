#!/bin/bash
set -x
set -e

# Update instance
sudo apt-get update
sudo apt-get install -y debconf-utils software-properties-common apt-transport-https ca-certificates curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
