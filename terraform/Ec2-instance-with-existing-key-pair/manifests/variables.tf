# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region where AWS Resources will be created"
  type = string
  default = "eu-west-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instnace Type"
  type = string
  default = "t2.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "test-key"
}
