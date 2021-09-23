#!/bin/bash
sudo apt-get update && sudo apt-get install default-jdk -y
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo apt-get -y install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo su - postgres
createuser sonar
psql
ALTER USER sonar WITH ENCRYPTED password 'password';
CREATE DATABASE sonarqube OWNER sonar;
\q
exit
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.7.zip
sudo apt-get -y install unzip
sudo unzip sonarqube-7.7.zip -d /opt
sudo mv /opt/sonarqube-7.7 /opt/sonarqube -v
sudo groupadd sonar
sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar 
sudo chown sonar:sonar /opt/sonarqube -R
sudo vi /opt/sonarqube/conf/sonar.properties