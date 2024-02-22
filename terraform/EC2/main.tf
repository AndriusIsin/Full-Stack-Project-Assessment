terraform {
  required_providers {
    aws = {                                     // Define required AWS provider
      source  = "hashicorp/aws"                
      version = "~> 5.37.0"                     
    }
  }
  required_version = ">= 1.0.0"                 // Terraform version constraint
}

provider "aws" {                                 // Configure AWS provider
  region = "eu-west-2"                          
}

resource "aws_security_group" "video_security" { // Define AWS security group resource
  name        = "video_andrius_security_group"  
  description = "Allow ports 8080 and 4000"     

  ingress {                                     // Define ingress rules
    from_port   = 8080                           
    to_port     = 8080                          
    protocol    = "tcp"                         
    cidr_blocks = ["0.0.0.0/0"]                 
  }

  ingress {                                     // Define another ingress rule
    from_port   = 4000                          
    to_port     = 4000                          
    protocol    = "tcp"                         
    cidr_blocks = ["0.0.0.0/0"]                  
  }

  egress {                                      // Define egress rule
    from_port   = 0                            
    to_port     = 0                             
    protocol    = "-1"                        
    cidr_blocks = ["0.0.0.0/0"]           
  }
}

resource "aws_instance" "video_andrius" {       // Define AWS EC2 instance resource
  instance_type          = "t2.micro"          
  ami                    = "ami-09d6bbc1af02c2ca1"  
  vpc_security_group_ids = [aws_security_group.video_security.id]  // Attach security group to the instance

  tags = {                                     
    Name = "video_andrius_instance"             // Name tag
  }
}
