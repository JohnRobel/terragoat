provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "a74324102e67020f97316867c9e32f4187116ad1"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-09 18:58:59"
    git_last_modified_by = "john@robel.net"
    git_modifiers        = "john"
    git_org              = "JohnRobel"
    git_repo             = "terragoat"
    yor_trace            = "c87bc121-8014-4d23-9c5c-875320b6a7c6"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "a74324102e67020f97316867c9e32f4187116ad1"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-09 18:58:59"
    git_last_modified_by = "john@robel.net"
    git_modifiers        = "john"
    git_org              = "JohnRobel"
    git_repo             = "terragoat"
    yor_trace            = "fcaf59ff-6b41-45ae-b5fa-f4bbed2b97bd"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
