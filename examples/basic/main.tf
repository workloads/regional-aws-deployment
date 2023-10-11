module "basic" {
  source = "../.."

  ami_id = data.aws_ami.main.image_id

  aws_region = var.aws_region

  launch_template_block_device_mappings = {
    # root device for Ubuntu 22.04 LTS
    device_name     = "/dev/sda1"
    ebs_volume_size = 50 # size in GB
  }

  launch_template_key_name = aws_key_pair.main.key_name

  launch_template_user_data = filebase64("${path.module}/templates/user-data.sh")

  launch_template_vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  security_group_vpc_id = data.aws_vpc.default.id

  tfe_organization = var.tfe_organization
}

## assemble Policy Description from user-supplied argument, and TFC-supplied AWS Region
#iam_policy_description = "${var.iam_policy_description} (for `${var.aws_region}`)."
