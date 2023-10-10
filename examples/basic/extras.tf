# The resources in this file are not required for the module itself, but
# are made available to allow for a better understanding of the module flow

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "main" {
  key_name_prefix = "${var.tfe_organization}-"

  # load locally available public key
  public_key = file("~/.ssh/id_rsa.pub")
}

# retrieve information about the Default VPC for the selected `aws_region`
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "default" {
  default = true
  state   = "available"
}

# retrieve information about the Default Security Group for the Default VPC
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}
