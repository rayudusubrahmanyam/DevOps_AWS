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
