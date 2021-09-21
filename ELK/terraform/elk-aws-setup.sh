#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install default-jre -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update && sudo apt-get install elasticsearch
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo apt-get install logstash -y
sudo systemctl enable logstash.service
sudo systemctl start logstash.service
sudo systemctl restart logstash.service
sudo apt-get install kibana -y
sudo systemctl enable kibana.service
sudo systemctl start kibana.service
