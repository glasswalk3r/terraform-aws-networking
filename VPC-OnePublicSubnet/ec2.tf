resource "aws_instance" "ssh" {
  ami                         = module.ami.id
  instance_type               = "t2.micro"
  key_name                    = module.ssh.ssh_pair_name
  tags                        = module.common_tags.tags
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.main_public.id
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.ec2_public.id]
}
