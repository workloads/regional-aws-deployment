locals {
  deployments = {
    # Nomad Client-specific configuration
    client = {
      autoscaling_group_desired_capacity = 2
      autoscaling_group_max_size         = 3
      autoscaling_group_min_size         = 1

      iam_name                 = "nomad-clients-${local.name_suffix}"
      iam_policy_description   = "Nomad Cient-specific Policy"
      iam_policy_document      = data.aws_iam_policy_document.iam_policy_client.json
      iam_role_policy_document = data.aws_iam_policy_document.iam_role.json
      iam_role_name            = local.name_suffix

      launch_template_tags_instance = {
        "nomad:role"    = "client"
        "service:nomad" = "true"
      }
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

      launch_template_tags_instance = {
        "nomad:role"    = "server"
        "service:nomad" = "true"
      }
    }
  }
}
