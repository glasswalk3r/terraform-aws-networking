output "ssh_pair_name" {
  value = aws_key_pair.ssh-instance-key.key_name
}

output "private_key_name" {
  value = var.ssh_key_private_name
}

output "keys_path" {
  value = var.ssh_keys_path
}
