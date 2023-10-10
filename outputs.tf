output "aws_ami" {
  description = "Exported Attributes for `aws_ami.main` data source."
  value       = data.aws_ami.main
}

output "aws_autoscaling_group" {
  description = "Exported Attributes for `aws_autoscaling_group`."
  value       = aws_autoscaling_group.main
}

output "aws_availability_zones" {
  description = "Exported Attributes for `aws_availability_zones.main` data source."
  value       = data.aws_availability_zones.main
}

output "aws_availability_zones_az" {
  description = "Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`)."
  value       = data.aws_availability_zones.main
}

output "aws_iam_role" {
  description = "Exported Attributes for `aws_iam_role`."
  value       = aws_iam_role.main
}

output "aws_iam_instance_profile" {
  description = "Exported Attributes for `aws_iam_instance_profile`."
  value       = aws_iam_instance_profile.main
}

output "aws_iam_policy" {
  description = "Exported Attributes for `aws_iam_policy`."
  value       = aws_iam_policy.main
}

output "aws_iam_role_policy_attachment" {
  description = "Exported Attributes for `aws_iam_role_policy_attachment`."
  value       = aws_iam_role_policy_attachment.main
}

output "aws_launch_template" {
  description = "Exported Attributes for `aws_launch_template`."
  value       = aws_launch_template.main
}

output "aws_placement_group" {
  description = "Exported Attributes for `aws_placement_group`."
  value       = aws_placement_group.main
}

output "random_string_suffix" {
  description = "Exported Attributes for `random_string.suffix`."
  value       = random_string.suffix
}
