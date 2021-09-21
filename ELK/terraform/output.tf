
output "demo-develop-elk-id" {
  value = aws_instance.demo-develop-elk.id
}

output "ec2-public-ip" {
  value = aws_instance.demo-develop-elk.public_ip
}