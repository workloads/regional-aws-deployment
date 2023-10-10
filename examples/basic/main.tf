module "basic" {
  source = "../.."

  aws_region = var.aws_region

  launch_template_key_name = aws_key_pair.main.key_name

  launch_template_tags_instance = {
    "nomad:role"    = "client"
    "service:nomad" = "true"
  }

  launch_template_user_data = filebase64("${path.module}/templates/user-data.sh")

  launch_template_vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  security_group_vpc_id = data.aws_vpc.default.id

  tfe_organization = var.tfe_organization
}
