#!/bin/bash
cat /etc/issue
sudo apt update && install curl
sudo curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get upgrade -y
sudo apt install docker.io -y
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
source ~/.bashrc
sleep 90
cd ~
git clone https://github.com/rayudusubrahmanyam/Nodejs-Docker-Jenkins.git
cd ~/Nodejs-Docker-Jenkins
docker build -t docker_web_app:1.0.0 .
docker run -d -p 8080:8080 docker_web_app:1.0.0