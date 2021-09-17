/*
resource "aws_instance" "demo-develop-jenkins-server" {
  ami                         = var.AMIS[var.REGION-ID]
  instance_type               = var.INSTANCE-TYPE
  key_name                    = "demo-develop-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo-develop-subnet-1.id
  volume_size                 = 20
  vpc_security_group_ids      = [aws_default_security_group.demo-develop-default-sg.id]
  availability_zone			  = var.AVAIL-ZONE-1

  user_data = <<-EOF
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
  sudo docker run -p 8080:8080 -p 50000:50000 -d -v jenkins_home:/var/jenkins_home \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $(which docker):/usr/bin/docker \
   --name jenkins_server jenkins/jenkins:lts
  EOF   

  tags = {
  Name = "demo-develop-jenkins-server"
  }

}  */