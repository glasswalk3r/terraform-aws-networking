module "common_tags" {
  source       = "../tags"
  environment  = var.environment
  project_name = var.project_name
}

module "ami" {
  source = "../ami"
}

locals {
  ami_id = var.ec2_ami_id != "" ? var.ec2_ami_id : module.ami.id
}

resource "aws_instance" "ec2" {
  ami                         = local.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.ssh_pair_name
  tags                        = merge(module.common_tags.tags, { "Name" = var.name })
  associate_public_ip_address = var.use_public_ip
  subnet_id                   = var.subnet_id
  source_dest_check           = var.do_src_dest_check
  vpc_security_group_ids      = var.vpc_security_group_ids
  monitoring                  = false
  user_data                   = data.template_file.user_data.rendered
}
