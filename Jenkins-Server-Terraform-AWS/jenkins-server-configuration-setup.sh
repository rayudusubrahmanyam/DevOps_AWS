#!/bin/bash
sudo apt update
sudo apt install openjdk-8-jdk -y
sudo apt install maven git wget unzip -y
sudo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
sudo export PATH=$PATH:$JAVA_HOME/bin
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get upgrade -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
sudo apt update && install curl
sudo curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo apt install nodejs -y
sudo apt update 
sudo apt install npm -y
sudo apt update 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y
sudo usermod -aG docker jenkins
sudo gpasswd -a jenkins docker
sudo setfacl -m user:jenkins:rw /var/run/docker.sock
sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
