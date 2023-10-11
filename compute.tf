module "scaled_compute" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for type, profile in local.deployments : type => profile
  }

  source = "./modules/terraform-aws-scaled-compute"

  ami_id             = var.ami_id
  aws_region         = var.aws_region
  availability_zones = data.aws_availability_zones.main.names

  autoscaling_group_desired_capacity = each.value.autoscaling_group_desired_capacity
  autoscaling_group_max_size         = each.value.autoscaling_group_max_size
  autoscaling_group_min_size         = each.value.autoscaling_group_min_size

  custom_prefix = "${each.key}-${var.aws_region}"
  custom_suffix = random_string.suffix.result

  iam_instance_profile_arn = module.instance_profiles[each.key].aws_iam_instance_profile.arn

  launch_template_block_device_mappings  = var.launch_template_block_device_mappings
  launch_template_instance_type          = var.launch_template_instance_type
  launch_template_key_name               = var.launch_template_key_name
  launch_template_tags_instance          = each.value.launch_template_tags_instance
  launch_template_user_data              = each.value.launch_template_user_data
  launch_template_vpc_security_group_ids = var.launch_template_vpc_security_group_ids

  security_group_vpc_id = var.security_group_vpc_id
}
