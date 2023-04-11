# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
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
  description = "AWS EC2 Key Pair associated with EC2 Instances"
  type = string
  default = "terraform-key"
}

# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t2.micro", "t2.small", "t3.large"]  
}

# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa" = "t2.small"
    "prod" = "t3.large"
  }
}
