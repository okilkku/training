#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-7aba681d
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-mockingbird
#

variable "aws_access_key" {
  #  default = "AKIAINPI4X3XB3O6YCFQ"
}

variable "aws_secret_key" {
  #  default = "ISGgZGJwi/VQpDnOSAc4Jk2wRK4ennGxBa6GjIna"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "num_webs" {
  default = "2"
}

provider "aws" {
  #  access_key = "AKIAINPI4X3XB3O6YCFQ"
  access_key = "${var.aws_access_key}"

  #  secret_key = "ISGgZGJwi/VQpDnOSAc4Jk2wRK4ennGxBa6GjIna"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  ami           = "ami-a4f9f2c2"
  instance_type = "t2.micro"
  count         = "${var.num_webs}"

  subnet_id              = "subnet-7aba681d"
  vpc_security_group_ids = ["sg-00100979"]

  tags {
    "Identity"     = "hdays-michel-mockingbird"
    "foo"          = "bar"
    "ykskakskolme" = "onetwothree"
    "Name" = "web ${count.index+1}/${var.num_webs}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

#module "example" {
#  source = "./example-module"
#  command = "echo Goodbye World"
#} 

terraform {
  backend "atlas" {
    name = "okilkku/training"
  }
}
