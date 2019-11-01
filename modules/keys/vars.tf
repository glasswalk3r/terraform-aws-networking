variable "ssh_keys_path" {
  description = "The complete path to the directory where SSH keys are to associate with EC2 instances"
}

variable "ssh_key_public_name" {
  description = "The filename of the SSH public key"
}

variable "ssh_key_private_name" {
  description = "The filename of the SSH private key (only used to print SSH command)"
}
