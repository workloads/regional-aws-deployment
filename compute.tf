# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "main" {
  key_name_prefix = "${var.project_identifier}-${var.aws_region}"

  # load locally available public key
  public_key = var.ssh_public_key
}

# see https://registry.terraform.io/modules/ksatirli/scaled-compute/aws/latest
module "scaled_compute" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for type, profile in local.deployments : type => profile
  }

  source = "git::https://github.com/ksatirli/terraform-aws-scaled-compute.git?ref=adds-code"

  aws_region         = var.aws_region
  availability_zones = data.aws_availability_zones.main.names

  autoscaling_group_desired_capacity = each.value.autoscaling_group_desired_capacity
  autoscaling_group_max_size         = each.value.autoscaling_group_max_size
  autoscaling_group_min_size         = each.value.autoscaling_group_min_size

  custom_prefix = "${each.key}-${var.aws_region}"
  custom_suffix = random_string.suffix.result

  iam_instance_profile_arn = module.instance_profiles[each.key].aws_iam_instance_profile.arn

  launch_template_block_device_mappings = each.value.launch_template_block_device_mappings
  launch_template_image_id              = data.aws_ami.main.image_id
  launch_template_instance_type         = each.value.launch_template_instance_type
  launch_template_key_name              = aws_key_pair.main.key_name
  launch_template_tags_instance         = each.value.launch_template_tags_instance
  launch_template_user_data             = each.value.launch_template_user_data

  launch_template_vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]
}
