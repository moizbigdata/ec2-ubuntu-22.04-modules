
# terraform {
#   required_version = ">= 1.0.0, < 2.0.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# provider "aws" {
#   region = var.vm_info.region
# }

# Create EC2 Instance

resource "aws_instance" "server" {
  # ami                    = "ami-0a482bdfdf4a33e61" #RHEL9 us-east-2
  ami                    = var.vm_info.instance_ami
  instance_type          = var.vm_info.instance_type
  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  private_ip             = var.vm_info.server_private_ip
  key_name               = var.vm_info.key_name
  root_block_device {
    volume_size           = var.vm_info.root_block_device.volume_size
    volume_type           = var.vm_info.root_block_device.volume_type
    delete_on_termination = var.vm_info.root_block_device.delete_on_termination
  }

  #user_data = file("${path.module}/user-data.sh")
  tags = merge(var.tags, {
    Name = "${var.vm_info.name}"
    }
  )
  # depends_on = [aws_key_pair.key]
}



