#!/bin/bash
set -x
set -e

# Update instance
sudo apt-get update
sudo apt-get install -y debconf-utils software-properties-common apt-transport-https ca-certificates curl
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer
sudo apt install oracle-java8-set-default -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update
sudo apt-get install git
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
