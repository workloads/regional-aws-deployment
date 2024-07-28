# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.aws_region

  # see https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags
  default_tags {
    tags = {
      "github:url"                 = "https://github.com/workloads/regional-aws-deployment"
      "hcp-terraform:organization" = var.tfe_organization
      "hcp-terraform:workspace"    = var.tfe_workspace
    }
  }
}
