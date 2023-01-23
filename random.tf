# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "suffix" {
  # TODO: enable when HCP Packer is set up
  #  keepers = {
  #    # Generate a new id each time we switch to a new AMI id
  #    ami_id = data.aws_ami.main
  #  }

  length  = 4
  lower   = true
  numeric = false
  upper   = false
  special = false
}

locals {
  zone_suffix = "-${random_string.suffix.result}"
}
