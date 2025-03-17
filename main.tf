provider "aws" {
  region = "ap-south-1" # Change to your preferred region
}

# Security Group to allow SSH and HTTP traffic
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Ubuntu)
resource "aws_instance" "web_server" {
  ami           = "ami-00bb6a80f01f03502" # Change to an Ubuntu AMI in your region
  instance_type = "t2.micro"
  key_name      = "key-pair" # Replace with your SSH key name

  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = {
    Name = "DockerWebServer"
  }
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
