variable "environment" {
  type        = string
  description = "Enviroment where the resource will be deployed, e.g. 'production', 'staging', 'development', 'beta', 'test'"
}

variable "valid_environments" {
  type        = list(string)
  description = "The valid environment variable expected"
  default     = ["production", "staging", "development", "qa", "test"]
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable tags {
  type        = map(string)
  description = "All the common tags for AWS resources for this project"
  default = {
    product     = "networking"
    team        = "development"
    cost_center = "IT"
    created_by  = "Terraform"
  }
}

variable asg_propagate_at_launch {
  type        = bool
  default     = true
  description = "Enables propagation of the tag to Amazon EC2 instances launched via this ASG"
}
