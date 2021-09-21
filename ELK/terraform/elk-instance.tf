resource "aws_instance" "demo-develop-elk" {
  ami                         = var.AMIS[var.REGION-ID]
  instance_type               = var.INSTANCE-TYPE
  key_name                    = "my-webapp-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo-develop-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.demo-develop-default-sg.id]
  availability_zone			      = var.AVAIL-ZONE-1

  user_data = file("elk-aws-setup.sh")
  tags = {
  Name = "demo-develop-elk"
  }
}