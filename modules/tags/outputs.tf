output "tags" {
  value = merge(var.tags,
    { "project_name" = data.null_data_source.values.outputs["project_name"],
      "environment"  = data.null_data_source.values.outputs["environment"]
    }
  )
}

output "asg_tags" {
  value = [
    { "key" = "project_name", "value" = data.null_data_source.values.outputs["project_name"], propagate_at_launch = var.asg_propagate_at_launch },
    { "key" = "environment", "value" = data.null_data_source.values.outputs["environment"], propagate_at_launch = var.asg_propagate_at_launch },
    { "key" = "product", "value" = var.tags["product"], propagate_at_launch = var.asg_propagate_at_launch },
    { "key" = "team", "value" = var.tags["team"], propagate_at_launch = var.asg_propagate_at_launch },
    { "key" = "cost_center", "value" = var.tags["cost_center"], propagate_at_launch = var.asg_propagate_at_launch },
  ]
}
