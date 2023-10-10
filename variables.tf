variable "autoscaling_group_desired_capacity" {
  type        = number
  description = "Desired Number of Instances in the Auto Scaling Group."
  default     = 1
}

variable "autoscaling_group_force_delete" {
  type        = bool
  description = "Toggle to enable Force Deletion of Instances in the Auto Scaling Group."
  default     = true
}

variable "autoscaling_group_health_check_grace_period" {
  type        = number
  description = "Grace Period for Health Check of the Auto Scaling Group."
  default     = 300 # value in seconds
}

variable "autoscaling_group_health_check_type" {
  type        = string
  description = "Type of Health Check of the Auto Scaling Group."
  default     = "ELB"
}

variable "autoscaling_group_launch_template_version" {
  type        = string
  description = "Version of Launch Template to use for Autoscaling Group."
  default     = "$Latest"
}

variable "autoscaling_group_max_size" {
  type        = number
  description = "Maximum Number of Instances in the Auto Scaling Group."
  default     = 1 # 3
}

variable "autoscaling_group_min_size" {
  type        = number
  description = "Minimum Number of Instances in the Auto Scaling Group."
  default     = 0 # 1
}

variable "aws_region" {
  type        = string
  description = "AWS Region."
}

variable "default_name_prefix" {
  type        = string
  description = "Default Name Prefix for Module-specific Resources."

  # name should not include a trailing slash
  default = "compute"
}

locals {
  # assemble "default name" from user-supplied prefix, TFC-supplied AWS Region, and a random string
  default_name = "${var.default_name_prefix}-${var.aws_region}-${random_string.suffix.result}"
}

variable "tfe_organization" {
  type        = string
  description = "Name of Terraform Cloud Organization."
}

variable "iam_policy_description" {
  type        = string
  description = "Description of the IAM policy."
  default     = "Regional Compute Deployment"
}

locals {
  # assemble Policy Description from user-supplied argument, and TFC-supplied AWS Region
  iam_policy_description = "${var.iam_policy_description} (for `${var.aws_region}`)."
}

variable "iam_role_path" {
  type        = string
  description = "Path for IAM Role."
  default     = "/"
}

variable "launch_template_block_device_mappings" {
  type = object({
    device_name     = string
    ebs_volume_size = number
  })

  description = "Block Device Configuration for Instances in Launch Template."

  default = {
    device_name     = "/dev/sdf"
    ebs_volume_size = 50 # size in GB
  }
}

variable "launch_template_disable_api_stop" {
  type        = bool
  description = "Toggle to enable EC2 Instance Stop Protection."
  default     = true
}

variable "launch_template_disable_api_termination" {
  type        = bool
  description = "Toggle to enable EC2 Instance Termination Protection."
  default     = true
}

variable "launch_template_ebs_optimized" {
  type        = bool
  description = "Toggle to enable starting Instances with optimized EBS.."
  default     = true
}

variable "launch_template_instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown Behavior for Instances in Launch Template."
  default     = "terminate"
}

variable "launch_template_instance_type" {
  type        = string
  description = "Type of EC2 Instance in Launch Template."

  # see https://instances.vantage.sh for more information
  default = "t2.small"
}

variable "launch_template_key_name" {
  type        = string
  description = "Name of (Public) Key for Instances in Launch Template."
}

variable "launch_template_metadata_options" {
  type = object({
    http_endpoint               = string
    http_protocol_ipv6          = string
    http_put_response_hop_limit = number
    http_tokens                 = string
    instance_metadata_tags      = string
  })

  description = "Metadata Options for Instances in Launch Template."

  default = {
    # enables IMDS v1 / v2
    http_endpoint = "enabled"

    # enable IPv6 support for IMDS
    http_protocol_ipv6 = "disabled"

    # Desired HTTP PUT response hop limit for requests.
    http_put_response_hop_limit = 1

    # enables IMDSv2 and requires a token to be passed in the header
    http_tokens = "required"

    # enable access to Instance Tags via IMDS
    instance_metadata_tags = "enabled"
  }
}

variable "launch_template_monitoring" {
  type = object({
    enabled = bool
  })

  description = "Monitoring for Instances in Launch Template."

  default = {
    enabled = true
  }
}

variable "launch_template_network_interfaces" {
  type = object({
    associate_public_ip_address = bool
    delete_on_termination       = bool
    description_prefix          = string
  })

  description = "Network Interfaces for Instances in Launch Template."

  default = {
    associate_public_ip_address = true
    delete_on_termination       = true
    description_prefix          = "Public IP for Instances"
  }
}

locals {
  launch_template_network_interfaces_description = "${var.launch_template_network_interfaces.description_prefix} in ASG `${local.default_name}`"
}

variable "launch_template_tags_instance" {
  type        = map(string)
  description = "Tags for Instances in Launch Template."

  default = null
}

variable "launch_template_tags_network_interface" {
  type        = map(string)
  description = "Tags for Network interface in Launch Template."

  default = {}
}

variable "launch_template_tags_volume" {
  type        = map(string)
  description = "Tags for Volumes in Launch Template."

  default = {}
}

locals {
  # `local.regional_name` is processed with `replace` and will have `%s` replaced by the AZ
  regional_name = "${var.default_name_prefix}-%s-${random_string.suffix.result}"
}

variable "launch_template_update_default_version" {
  type        = bool
  description = "Toggle to update the Default Version of the Launch Template."
  default     = true
}

variable "launch_template_user_data" {
  type        = string
  description = "User Data for Instances in Launch Template."
}

variable "launch_template_vpc_security_group_ids" {
  type        = list(string)
  description = "List of Security Group IDs for Instances in Launch Template."
}

#variable "placement_group_partition_count" {
#  type        = number
#  description = "Number of Partitions in the Placement Group."
#  default     = 3
#
#  validation {
#    condition     = var.placement_group_partition_count >= 1 && var.placement_group_partition_count <= 7
#    error_message = "Partition Count must be between `1` and `7`."
#  }
#}

variable "placement_group_spread_level" {
  type        = string
  description = "Spread Level of Placement Groups."
  default     = "rack"
}

variable "security_group_vpc_id" {
  type        = string
  description = "VPC ID of Security Group."
}
