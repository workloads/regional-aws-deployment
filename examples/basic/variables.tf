variable "aws_region" {
  type        = string
  description = "AWS Region."
  default     = "us-west-2"
}

variable "tfe_organization" {
  type        = string
  description = "Name of Terraform Cloud Organization."
  default     = "workloads"
}
