output "aws_availability_zones_az" {
  description = "Exported Attributes for `aws_availability_zones` (filtered by type `availability-zone`)."
  value       = data.aws_availability_zones.availability_zones
}

output "instance_ami" {
  description = "Exported Attributes for `aws_ami.main` data source."
  value       = data.aws_ami.main
}

output "random_string_suffix" {
  description = "Exported Attributes for `random_string.suffix`."
  value       = random_string.suffix
}

output "zone_specific_suffix" {
  description = "Zone-specific Suffix for Resources."
  value       = local.zone_suffix
}
