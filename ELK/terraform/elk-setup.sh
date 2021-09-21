 #!/bin/bash
  # Install elasticsearch
  sudo apt-get update
  sudo apt-get install openjdk-7-jre-headless -y
  sudo wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  sudo echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list
  sudo apt-get update
  sudo apt-get install elasticsearch
  sudo systemctl enable elasticsearch
  sudo systemctl start elasticsearch
  # Install Logstash
  sudo echo "deb http://packages.elasticsearch.org/logstash/1.5/debian stable main" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update
  sudo apt-get install logstash -y
  sudo apt-get update
  sudo systemctl enable logstash
  sudo systemctl start logstash
  # Install Kibana
  sudo wget https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz
  sudo tar -xzf kibana
  sudo mkdir -p /opt/kibana
  sudo mv kibana-4.1.1-linux-x64//* /opt/kibana
  cd /etc/init.d && sudo wget https://raw.githubusercontent.com/akabdog/scripts/master/kibana4_init -O kibana4
  sudo chmod +x /etc/init.d/kibana4
  sudo update-rc.d kibana4 defaults 96 9
  sudo systemctl start kibana4