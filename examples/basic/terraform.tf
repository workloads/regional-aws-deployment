terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/5.25.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0, < 6.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.5.1/
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.6.0, < 2.0.0"
}
