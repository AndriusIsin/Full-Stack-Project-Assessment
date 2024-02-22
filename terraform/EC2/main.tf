terraform {
  required_providers {
    aws = {                                    
      source  = "hashicorp/aws"                
      version = "~> 5.37.0"                     
    }
  }
  required_version = ">= 1.0.0"                
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "video_security" {
  name        = "video_andrius_security_group"
  description = "Allow ports 22, 8080, and 4000"

 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Additional rules
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "video_andrius" {
  instance_type          = "t2.micro"
  ami                    = "ami-09d6bbc1af02c2ca1"
  vpc_security_group_ids = [aws_security_group.video_security.id]
  key_name               = "NodeApplicationLoginKey" 


  tags = {
    Name = "video_andrius_instance"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"  
      private_key = file("/Users/andriusisin/Downloads/NodeApplicationLoginKey.pem")
      host        = self.public_ip
    }

    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }
}
