module "common_tags" {
  source       = "../modules/tags"
  environment  = var.environment
  project_name = var.project_name
}

module "ip" {
  source  = "JamesWoolfenden/ip/http"
  version = "0.2.7"
}

module "ssh" {
  source               = "../modules/keys"
  ssh_keys_path        = "/home/alceu/.ssh"
  ssh_key_public_name  = "aws_ec2.pub"
  ssh_key_private_name = "aws_ec2"
}

module "ec2_public" {
  source                 = "../modules/ec2"
  use_public_ip          = true
  subnet_id              = aws_subnet.main_public.id
  vpc_security_group_ids = [aws_security_group.ec2_public.id]
  name                   = "EC2-A"
  environment            = var.environment
  ssh_pair_name          = module.ssh.ssh_pair_name
  project_name           = var.project_name
  # enable SSH agent forward
  additional_cmd = "sudo sed -i -e 's/^#\\(AllowAgentForwarding yes\\)/\\1/' /etc/ssh/sshd_config"
}

module "ec2_private" {
  source                 = "../modules/ec2"
  use_public_ip          = false
  subnet_id              = aws_subnet.main_private.id
  vpc_security_group_ids = [aws_security_group.ec2_private.id]
  name                   = "EC2-B"
  environment            = var.environment
  ssh_pair_name          = module.ssh.ssh_pair_name
  project_name           = var.project_name
}
