# Define the AWS provider and region
provider "aws" {
  region = "eu-west-2"
}

# Use an existing VPC
data "aws_vpc" "existing" {
  id = "vpc-0046d4dffe9dcc0be"
}

# Use an existing subnet group
data "aws_db_subnet_group" "existing" {
  name = "default-vpc-0046d4dffe9dcc0be"
}

# Create an RDS instance using the existing security group
resource "aws_db_instance" "videodb" {
  identifier                  = "videodb"
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "postgres"
  engine_version              = "15.5"
  instance_class              = "db.t3.micro"
  publicly_accessible         = true 
  db_subnet_group_name        = data.aws_db_subnet_group.existing.name
  vpc_security_group_ids      = ["sg-0558f33e4502e9ccc"] 
  backup_retention_period     = 0
  backup_window               = "00:00-00:30"
  maintenance_window          = "mon:01:48-mon:02:18"
  auto_minor_version_upgrade  = true
  username                    = "andrius"   
  password                    = "password"   
  parameter_group_name        = "default.postgres15"
}
