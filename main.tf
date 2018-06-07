variable "region" {}
variable "shared_credentials_file" {}
variable "profile" {}
variable "webp_ami" {}
variable "webp_instance_type" {}
variable "key_name" {}
variable "count" {}

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.profile}"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "with_ssh" {
  name   = "with-ssh-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-performance-test" {
  ami             = "${var.webp_ami}"
  instance_type   = "${var.webp_instance_type}"
  security_groups = ["${aws_security_group.with_ssh.name}"]
  key_name        = "${var.key_name}"
  count           = "${min(var.count, 2) - 1}"              # we subtract one due to the machine dedicated to mobile api testing
  user_data       = "${file("provision/provisioner.sh")}"

  tags {
    Name = "web"
  }
}

resource "aws_instance" "mobile-performance-test" {
  ami             = "${var.webp_ami}"
  instance_type   = "${var.webp_instance_type}"
  security_groups = ["${aws_security_group.with_ssh.name}"]
  key_name        = "${var.key_name}"
  count           = 1
  user_data       = "${file("provision/provisioner.sh")}"

  tags {
    Name = "mobile"
  }
}
