terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    # The Terraform Cloud configuration will be retrieved from the executing environment
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/5.0.1/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.1, < 6.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.5.1/
    random = {
      source  = "hashicorp/random"
      version = "3.5.1, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.4.0, < 1.5.0"
}
