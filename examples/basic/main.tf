locals {
  # assemble dynamic User Data and associated Nomad configuration files

  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  client_config_nomad = templatefile("../../templates/nomad-client-config.tftpl.hcl", {
    datacenter = var.aws_region

    join_tags = [
      # primary cluster
      "provider=aws region=${var.aws_region} tag_key=nomad:role tag_value=server addr_type=public_v4",

      # alternate regions, for federation
      "provider=aws region=us-east-1 tag_key=nomad:role tag_value=server addr_type=public_v4",
      "provider=aws region=us-west-1 tag_key=nomad:role tag_value=server addr_type=public_v4"
    ]

    region = "aws"
  })

  # see https://developer.hashicorp.com/terraform/language/functions/base64encode
  # and https://developer.hashicorp.com/terraform/language/functions/templatefile
  client_user_data = base64encode(templatefile("../../templates/user-data.tftpl.sh", {
    NOMAD_CONFIG_DATA = base64encode(local.client_config_nomad)
  }))

  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  server_config_nomad = templatefile("../../templates/nomad-server-config.tftpl.hcl", {
    datacenter = var.aws_region

    join_tags = [
      # primary cluster
      "provider=aws region=${var.aws_region} tag_key=nomad:role tag_value=server addr_type=public_v4",

      # secondary regions
      "provider=aws region=us-east-1 tag_key=nomad:role tag_value=server addr_type=public_v4"
    ]

    region = "aws"
  })

  # see https://developer.hashicorp.com/terraform/language/functions/base64encode
  # and https://developer.hashicorp.com/terraform/language/functions/templatefile
  server_user_data = base64encode(templatefile("../../templates/user-data.tftpl.sh", {
    NOMAD_CONFIG_DATA = base64encode(local.server_config_nomad)
  }))
}

module "basic" {
  source = "../.."


  aws_region = var.aws_region

  launch_template_block_device_mappings = {
    # root device for Ubuntu 22.04 LTS
    device_name     = "/dev/sda1"
    ebs_volume_size = 50 # size in GB
  }

  launch_template_image_id = data.aws_ami.main.image_id
  launch_template_key_name = aws_key_pair.main.key_name

  launch_template_user_data = {
    client = local.client_user_data
    server = local.server_user_data
  }

  launch_template_vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  security_group_vpc_id = data.aws_vpc.default.id

  tfe_organization = var.tfe_organization
}
