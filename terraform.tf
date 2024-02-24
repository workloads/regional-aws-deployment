terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    # The Terraform Cloud configuration will be retrieved from the executing environment
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/5.38.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0, < 6.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.6.0/
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.7.0, < 2.0.0"
}
