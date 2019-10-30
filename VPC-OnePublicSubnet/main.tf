module "common_tags" {
  source       = "../modules/tags"
  environment  = var.environment
  project_name = "VPC-OnePublicSubnet"
}

module "ip" {
  source  = "JamesWoolfenden/ip/http"
  version = "0.2.7"
}

module "ami" {
  source = "../modules/ami"
}

module "ssh" {
  source = "../modules/keys"
  ssh_keys_path = "/home/alceu/.ssh"
  ssh_key_public_name = "aws_ec2.pub"
  ssh_key_private_name = "aws_ec2"
}
