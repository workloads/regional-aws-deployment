locals {
  # TODO: populate this from var.management_region_aws (TFC Var Set)
  authoritative_region = "aws-us-west-2"
  nomad_region         = "aws-${var.aws_region}"

  # assemble dynamic User Data and associated Nomad configuration files
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  client_config_nomad = templatefile("${path.module}/templates/nomad-client-config.tftpl.hcl", {
    datacenter = local.nomad_region

    join_tags = [
      "provider=aws region=${var.aws_region} tag_key=nomad:role tag_value=server addr_type=public_v4",
    ]

    region = local.nomad_region
  })

  # see https://developer.hashicorp.com/terraform/language/functions/base64encode
  # and https://developer.hashicorp.com/terraform/language/functions/templatefile
  client_user_data = base64encode(templatefile("${path.module}/templates/user-data.tftpl.sh", {
    NOMAD_CONFIG_DATA = base64encode(local.client_config_nomad)
  }))

  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  server_config_nomad = templatefile("${path.module}/templates/nomad-server-config.tftpl.hcl", {
    authoritative_region = local.authoritative_region

    datacenter = local.nomad_region

    join_tags = [
      "provider=aws region=${var.aws_region} tag_key=nomad:role tag_value=server addr_type=public_v4",
    ]

    region = local.nomad_region
  })

  # see https://developer.hashicorp.com/terraform/language/functions/base64encode
  # and https://developer.hashicorp.com/terraform/language/functions/templatefile
  server_user_data = base64encode(templatefile("${path.module}/templates/user-data.tftpl.sh", {
    NOMAD_CONFIG_DATA = base64encode(local.server_config_nomad)
  }))
}

locals {
  deployments = {
    # Nomad Client-specific configuration
    client = {
      autoscaling_group_desired_capacity = 3
      autoscaling_group_max_size         = 3
      autoscaling_group_min_size         = 1

      iam_name                 = "nomad-clients-${local.name_suffix}"
      iam_policy_description   = "Nomad Cient-specific Policy"
      iam_policy_document      = data.aws_iam_policy_document.iam_policy_client.json
      iam_role_policy_document = data.aws_iam_policy_document.iam_role.json
      iam_role_name            = local.name_suffix

      launch_template_block_device_mappings = {
        # root device for Ubuntu 22.04 LTS
        device_name     = "/dev/sda1"
        ebs_volume_size = 50 # size in GB
      }

      launch_template_instance_type = var.launch_template_instance_type_client

      launch_template_tags_instance = {
        "nomad:role"    = "client"
        "service:nomad" = "true"
      }

      launch_template_user_data = local.client_user_data
    }

    # Nomad Server-specific configuration
    server = {
      autoscaling_group_desired_capacity = 3
      autoscaling_group_max_size         = 3
      autoscaling_group_min_size         = 3

      iam_name                 = "nomad-servers-${local.name_suffix}"
      iam_policy_description   = "Nomad Server-specific Policy"
      iam_policy_document      = data.aws_iam_policy_document.iam_policy_server.json
      iam_role_policy_document = data.aws_iam_policy_document.iam_role.json
      iam_role_name            = local.name_suffix

      launch_template_block_device_mappings = {
        # root device for Ubuntu 22.04 LTS
        device_name     = "/dev/sda1"
        ebs_volume_size = 50 # size in GB
      }

      launch_template_instance_type = var.launch_template_instance_type_server

      launch_template_tags_instance = {
        "nomad:role"    = "server"
        "service:nomad" = "true"
      }

      launch_template_user_data = local.server_user_data
    }
  }
}
