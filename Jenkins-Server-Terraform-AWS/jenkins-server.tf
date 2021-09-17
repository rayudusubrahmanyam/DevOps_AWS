variable SSH-PUBLIC-KEY{}

resource "aws_key_pair" "rayudu123-key" {
  key_name   = "rayudu123-key"
  public_key = var.SSH-PUBLIC-KEY
}

resource "aws_instance" "jenkins-server" {
  ami                         = var.AMIS[var.REGION-ID]
  instance_type               = var.INSTANCE-TYPE
  key_name                    = "rayudu123-key"
  associate_public_ip_address = true
  #subnet_id                   = aws_subnet.demo-develop-subnet-1.id
  #vpc_security_group_ids      = [aws_default_security_group.demo-develop-default-sg.id]
  availability_zone			      = var.AVAIL-ZONE-1

  user_data = file("jenkins-server-configuration-setup.sh")
  tags = {
  Name = "jenkins-server"
  }

}