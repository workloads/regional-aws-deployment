variable "aws_region" {
  type        = string
  description = "AWS Region."
}

locals {
  # assemble "default name" from user-supplied prefix, TFC-supplied AWS Region, and a random string
  name_suffix = "${var.aws_region}-${random_string.suffix.result}"
}

variable "iam_policy_description" {
  type        = string
  description = "Description of the IAM policy."
  default     = "Regional Compute Deployment"
}

variable "launch_template_instance_type" {
  type        = string
  description = "Type of EC2 Instance in Launch Template."

  # not all EC2 Instance Types may be available in all Availability Zones
  # see https://instances.vantage.sh for more information on all Types
  # and https://developer.hashicorp.com/nomad/tutorials/enterprise/production-reference-architecture-vm-with-consul#nomad-servers
  # for guidance from HashiCorp on what types of EC2 Instances to use for Nomad Servers
  default = "t3.small"
}

variable "project_identifier" {
  type        = string
  description = "Human-readable Project Identifier."
}

variable "tfe_organization" {
  type        = string
  description = "Name of Terraform Cloud Organization."
}

variable "tfe_workspace" {
  description = "Name of Terraform Cloud Workspace."
  type        = string
}
