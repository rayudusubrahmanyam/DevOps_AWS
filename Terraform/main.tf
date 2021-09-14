provider "aws" {
    region= "ap-south-1"
}

variable avail_zone {}

variable instance_type {}
variable ssh_key {}
variable my_ip {}

data "aws_ami" "amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.amazon-linux-image.id
}

resource "aws_vpc" "demo-develop-vpc"{
cidr_block ="10.0.0.0/16"
enable_dns_support = true
enable_dns_hostnames = true
    tags = {
        Name: "demo-develop-vpc"
    }
}

resource "aws_subnet" "demo-develop-subnet-1"{
    vpc_id= aws_vpc.demo-develop-vpc.id
    cidr_block="10.0.1.0/24"
    # availability_zone = var.avail_zone
    tags = {
        Name: "demo-develop-subnet-1"
    }
}    

resource "aws_internet_gateway" "demo-develop-igw" {
  vpc_id = aws_vpc.demo-develop-vpc.id
  tags = {
    Name = "demo-develop-igw"
  }
}

resource "aws_egress_only_internet_gateway" "demo-develop-egress-only-igw" {
  vpc_id = aws_vpc.demo-develop-vpc.id

  tags = {
    Name = "demo-develop-egress-only-igw"
  }
}

resource "aws_security_group" "demo-develop-sg" {
  name   = "demo-develop-sg"
  vpc_id = aws_vpc.demo-develop-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "demo-develop-sg"
  }
}



resource "aws_route_table" "demo-develop-route-table" {
   vpc_id = aws_vpc.demo-develop-vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.demo-develop-igw.id
   }

   # default route, mapping VPC CIDR block to "local", created implicitly and cannot be specified.

   tags = {
     Name = "demo-develop-route-table"
   }
 }
# Associate subnet with Route Table
resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id      = aws_subnet.demo-develop-subnet-1.id
  route_table_id = aws_route_table.demo-develop-route-table.id
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "demo-develop-key"
  public_key = file(var.ssh_key)
}

output "server-ip" {
    value = aws_instance.demo-develop-server.public_ip
}

resource "aws_instance" "demo-develop-server" {
  ami                         = data.aws_ami.amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = "demo-develop-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo-develop-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.demo-develop-sg.id]
  availability_zone			      = var.avail_zone

  tags = {
    Name = "demo-develop-server"
  }

  user_data = <<EOF
                 #!/bin/bash
                 apt-get update && apt-get install -y docker-ce
                 systemctl start docker
                 usermod -aG docker ec2-user
                 docker run -p 8080:8080 nginx
              EOF
}


