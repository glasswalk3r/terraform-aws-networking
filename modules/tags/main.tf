locals {
  trimmed_env_name = lower(trimspace(var.environment))
  temp             = contains(var.valid_environments, local.trimmed_env_name) ? local.trimmed_env_name : "'${local.trimmed_env_name}' is a invalid environment name!"
}


data "null_data_source" "values" {
  inputs = {
    project_name = lower(trimspace(var.project_name))
    # this a hack to generate an error message if the environment name is not one of the list
    position    = index(var.valid_environments, local.temp)
    environment = local.trimmed_env_name
  }
}
