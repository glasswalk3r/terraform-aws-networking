variable "use_public_ip" {
  description = "If the EC2 instance should use (true) or not (false) an valid IP address"
  type        = bool
}

variable "subnet_id" {
  description = "Subnet Id to associated the EC2 instance with"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security groups to associated with"
  type        = list(string)
}

variable "name" {
  description = "The name to associated with the EC2 instance"
  type        = string
}

variable "environment" {
  description = "The name of the environment the EC2 instance will be created"
  type        = string
}


variable "ssh_pair_name" {
  description = "The SSH key pair name to associated with"
  type        = string
}


variable "project_name" {
  description = "The name of the project the EC2 instance is associated with"
  type        = string
}

variable "additional_cmd" {
  description = "Additional commands to execute in the EC2 instance user data script"
  type        = string
  default     = ""
}
