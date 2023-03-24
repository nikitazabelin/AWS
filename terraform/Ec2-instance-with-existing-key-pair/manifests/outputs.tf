# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 instance Public IP"
  value = aws_instance.EC2TerraormTest.public_ip
}

# EC2 Instance Public DNS
output "instance_publicdns" {
  description = "EC2 instance Public DNS"
  value = aws_instance.EC2TerraormTest.public_dns
}