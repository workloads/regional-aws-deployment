output "aws_autoscaling_group" {
  description = "Exported Attributes for `aws_autoscaling_group`."
  value       = module.scaled_compute.aws_autoscaling_group
}

output "aws_availability_zones" {
  description = "Exported Attributes for `aws_availability_zones.main` data source."
  value       = data.aws_availability_zones.main
}

output "aws_availability_zones_az" {
  description = "Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`)."
  value       = data.aws_availability_zones.main
}

output "aws_iam_roles" {
  description = "Exported Attributes for `aws_iam_role`."

  # iterate over type-specific IAM Role(s)
  value = {
    for identifier, data in module.instance_profiles : identifier => module.instance_profiles[identifier].aws_iam_role
  }
}

output "aws_iam_instance_profiles" {
  description = "Exported Attributes for `aws_iam_instance_profile`."

  # iterate over type-specific Instance Profiles
  value = {
    for identifier, data in module.instance_profiles : identifier => module.instance_profiles[identifier].aws_iam_instance_profile
  }
}

output "aws_iam_policies" {
  description = "Exported Attributes for `aws_iam_policy`."

  # iterate over type-specific IAM Policies
  value = {
    for identifier, data in module.instance_profiles : identifier => module.instance_profiles[identifier].aws_iam_policy
  }
}

output "aws_iam_role_policy_attachments" {
  description = "Exported Attributes for `aws_iam_role_policy_attachment`."

  # iterate over type-specific IAM Policy Attachments
  value = {
    for identifier, data in module.instance_profiles : identifier => module.instance_profiles[identifier].aws_iam_role_policy_attachment
  }
}

output "aws_launch_template" {
  description = "Exported Attributes for `aws_launch_template`."

  # iterate over type-specific IAM Policy Attachments
  value = {
    for identifier, data in module.scaled_compute : identifier => module.instance_profiles[identifier].aws_iam_role_policy_attachment
  }
}

output "aws_placement_groups" {
  description = "Exported Attributes for `aws_placement_group`."

  # iterate over type-specific Placement Groups
  value = {
    for identifier, data in module.scaled_compute : identifier => module.scaled_compute[identifier].aws_placement_group
  }
}

output "random_string_suffix" {
  description = "Exported Attributes for `random_string.suffix`."
  value       = random_string.suffix
}
