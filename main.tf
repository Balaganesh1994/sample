provider "aws" {
  region = "us-east-1"
}

# Data block to get the information about the EC2 instance by its ID
data "aws_instance" "my_instance" {
  instance_id = "i-0d2c729fa9d81bf7a"
}

# Output the information you need from the instance
output "instance_id" {
  value = data.aws_instance.my_instance.id
}

output "instance_public_ip" {
  value = data.aws_instance.my_instance.public_ip
}

output "instance_private_ip" {
  value = data.aws_instance.my_instance.private_ip
}

output "instance_state" {
  value = data.aws_instance.my_instance.state
}

output "instance_type" {
  value = data.aws_instance.my_instance.instance_type
}
