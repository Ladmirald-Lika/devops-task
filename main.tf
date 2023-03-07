provider "aws" {
  region = "eu-central-1"
}

// security group creation
resource "aws_security_group" "allow-all-sg" {
name_prefix = "allow-all-sg"
#vpc_id = "vpc-094258820a9889486"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
// Ec2 Creation
resource "aws_instance" "control1" {
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.medium"
  key_name      = "aldi"
  vpc_security_group_ids = [aws_security_group.allow-all-sg.id]
  ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 20
  }
  tags = {
    Name = "control1"
  }
   provisioner "file" {
    content  = var.private_key
    filename = "${path.module}/private_key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "cat ${path.module}/private_key.pem >> ~/.ssh/authorized_keys",
      "rm ${path.module}/private_key.pem",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
resource "aws_instance" "worker1" {
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.small"
  key_name      = "aldi"
  vpc_security_group_ids = [aws_security_group.allow-all-sg.id]
  ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 20
  }
  tags = {
    Name = "worker1"
  }
   provisioner "file" {
    content  = var.private_key
    filename = "${path.module}/private_key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "cat ${path.module}/private_key.pem >> ~/.ssh/authorized_keys",
      "rm ${path.module}/private_key.pem",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
resource "aws_instance" "worker2" {
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.small"
  key_name      = "aldi"
  vpc_security_group_ids = [aws_security_group.allow-all-sg.id]
  ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 20
  }
  tags = {
    Name = "worker2"
  }
   provisioner "file" {
    content  = var.private_key
    filename = "${path.module}/private_key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "cat ${path.module}/private_key.pem >> ~/.ssh/authorized_keys",
      "rm ${path.module}/private_key.pem",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
output "ec2_public_ip_control1" {
  value = ["${aws_instance.control1.public_ip}"]
}
output "ec2_public_ip_worker1" {
  value = ["${aws_instance.worker1.public_ip}"]
}
output "ec2_public_ip_worker2" {
  value = ["${aws_instance.worker2.public_ip}"]
}
