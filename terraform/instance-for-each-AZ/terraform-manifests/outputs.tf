# Terraform Output Values
# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = toset([for instance in aws_instance.myec2vm: instance.public_ip])
}

# EC2 Instance Public DNS
output "instance_publicdns2" {
  value = tomap({for az, instance in aws_instance.myec2vm: az => instance.public_dns})
}


