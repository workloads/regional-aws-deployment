terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    # The Terraform Cloud configuration will be retrieved from the executing environment
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/4.51.0/
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.51.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.4.3/
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.3.0"
}
