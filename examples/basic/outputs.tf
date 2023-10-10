output "aws_ami" {
  description = "Exported Attributes for `aws_ami.main` data source."
  value       = module.basic.aws_ami
}

output "aws_autoscaling_group" {
  description = "Exported Attributes for `aws_autoscaling_group`."
  value       = module.basic.aws_autoscaling_group
}

output "aws_availability_zones" {
  description = "Exported Attributes for `aws_availability_zones.main` data source."
  value       = module.basic.aws_availability_zones
}

output "aws_availability_zones_az" {
  description = "Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`)."
  value       = module.basic.aws_availability_zones_az
}

output "aws_iam_role" {
  description = "Exported Attributes for `aws_iam_role`."
  value       = module.basic.aws_iam_role
}

output "aws_iam_instance_profile" {
  description = "Exported Attributes for `aws_iam_instance_profile`."
  value       = module.basic.aws_iam_instance_profile
}

output "aws_iam_policy" {
  description = "Exported Attributes for `aws_iam_policy`."
  value       = module.basic.aws_iam_policy
}

output "aws_iam_role_policy_attachment" {
  description = "Exported Attributes for `aws_iam_role_policy_attachment`."
  value       = module.basic.aws_iam_role_policy_attachment
}

# see `extras.tf`
output "aws_key_pair" {
  description = "Exported Attributes for `aws_key_pair`."
  value       = aws_key_pair.main
}

output "aws_launch_template" {
  description = "Exported Attributes for `aws_launch_template`."
  value       = module.basic.aws_launch_template
}

output "aws_placement_group" {
  description = "Exported Attributes for `aws_placement_group`."
  value       = module.basic.aws_placement_group
}

output "random_string_suffix" {
  description = "Exported Attributes for `random_string.suffix`."
  value       = module.basic.random_string_suffix
}

#output "zone_specific_suffix" {
#  description = "Zone-specific Suffix for Resources."
#  value       = module.basic.zone_specific_suffix
#}
