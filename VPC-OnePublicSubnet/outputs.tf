output "ec2_ip" {
  value = "ssh -i ${module.ssh.keys_path}/${module.ssh.private_key_name} ec2-user@${aws_instance.ssh.public_ip}"
}
