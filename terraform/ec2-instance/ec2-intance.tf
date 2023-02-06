#resource: EC2 Instance
resource "aws_instance" "myec2instance" {
    ami = "ami-0aa7d40eeae50c9a9"
    instance_type = "t2.micro"
    user_data = file("${path.module}/app-install.sh")
    tags = {
        "Name" = "EC2 Test"
    }
}