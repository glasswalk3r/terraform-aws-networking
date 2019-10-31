output "ec2_public_conn" {
  value = module.ec2_public.public_conn
}

output "ec2_private_ip" {
  value = module.ec2_private.private_conn
}
