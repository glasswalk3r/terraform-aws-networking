data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")
  vars = {
    ADDITIONAL_CMD = var.additional_cmd
  }
}
