resource "aws_key_pair" "ssh-instance-key" {
  key_name   = "standard-ec2-instance-key"
  public_key = file("${var.ssh_keys_path}/${var.ssh_key_public_name}")
  lifecycle {
    ignore_changes = [public_key]
  }
}
