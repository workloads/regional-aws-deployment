# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  # The AWS Provider is set to retrieve configuration from the executing environment

  # see https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags
  default_tags {
    tags = {
      "github:url"                   = "https://github.com/workloads/regional-aws-deployment"
      "terraform-cloud:organization" = var.tfe_organization
    }
  }
}
