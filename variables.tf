variable "ami_id" {
  type        = string
  description = "AMI ID to use for Instances in the Auto Scaling Group."
}

variable "aws_region" {
  type        = string
  description = "AWS Region."
}

locals {
  # assemble "default name" from user-supplied prefix, TFC-supplied AWS Region, and a random string
  name_suffix = "${var.aws_region}-${random_string.suffix.result}"
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

variable "launch_template_block_device_mappings" {
  type = object({
    device_name     = string
    ebs_volume_size = number
  })

  description = "Block Device Configuration for Instances in Launch Template."
}

variable "launch_template_instance_type" {
  type        = string
  description = "Type of EC2 Instance in Launch Template."

  # not all EC2 Instance Types are avaialble in all Availability Zones
  # see https://instances.vantage.sh for more information
  default = "t3.small"
}

variable "launch_template_key_name" {
  type        = string
  description = "Name of (Public) Key for Instances in Launch Template."
}

variable "launch_template_user_data" {
  type        = map(string)
  description = "User Data for Instances in Launch Template."
}

variable "launch_template_vpc_security_group_ids" {
  type        = list(string)
  description = "List of Security Group IDs for Instances in Launch Template."
}

variable "security_group_vpc_id" {
  type        = string
  description = "VPC ID of Security Group."
}
